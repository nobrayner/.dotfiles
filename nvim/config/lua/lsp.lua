local function go_tool_declared(needle)
    local gomod = vim.fs.find("go.mod", { upward = true })[1]

    if not gomod then
        return false
    end

    local in_block = false

    for line in io.lines(gomod) do
        if in_block then
            if line:match("^%s*%)") then
                in_block = false
            elseif line:find(needle, 1, true) then
                return true
            end
        elseif line:match("^%s*tool%s*%(") then
            in_block = true
        else
            local single = line:match("^%s*tool%s+(%S+)")
            if single and single:find(needle, 1, true) then
                return true
            end
        end
    end
    return false
end

local lsp_servers = {
    gopls = function()
        return vim.fn.executable("gopls") == 1
    end,

    templ = function()
        return vim.fn.executable("go") == 1 and go_tool_declared("templ")
    end,
}

-- Rewrite a definition Location that lands in generated `*_templ.go` back to the
-- `.templ` source (templ's LSP only remaps positions *within* templ files, so a
-- `gd` from a .go file into a component lands in generated code). Anything that
-- isn't a generated file returns immediately via the fast path.
local function templ_remap(loc)
    local uri = loc.uri or loc.targetUri
    local range = loc.range or loc.targetSelectionRange
    local path = vim.uri_to_fname(uri)

    if not path:find("_templ%.go$") then
        return { uri = uri, range = range }
    end

    local templ_path = path:gsub("_templ%.go$", ".templ")

    if not vim.uv.fs_stat(templ_path) then
        return { uri = uri, range = range }
    end

    -- name of the generated Go symbol at the target line, e.g. `func Layout(`
    local gen = vim.fn.readfile(path, "", range.start.line + 1)
    local name = (gen[#gen] or ""):match("func%s+([%w_]+)")

    if name then
        for i, text in ipairs(vim.fn.readfile(templ_path)) do
            local col = text:find("templ%s+" .. name .. "%s*%(")
                or text:find("css%s+" .. name .. "%s*%(")
                or text:find("script%s+" .. name .. "%s*%(")

            if col then
                return {
                    uri = vim.uri_from_fname(templ_path),
                    range = {
                        start = { line = i - 1, character = col - 1 },
                        ["end"] = { line = i - 1, character = col - 1 },
                    },
                }
            end
        end
    end

    return { uri = uri, range = range } -- couldn't relocate; keep original
end

local function goto_definition()
    local client = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/definition" })[1]

    if not client then
        return
    end

    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

    client:request("textDocument/definition", params, function(err, result)
        if err or not result or vim.tbl_isempty(result) then
            return
        end

        local locations = vim.islist(result) and result or { result }
        local remapped = vim.tbl_map(templ_remap, locations)

        if #remapped == 1 then
            vim.lsp.util.show_document(remapped[1], client.offset_encoding, { focus = true })
            return
        end

        local items = vim.lsp.util.locations_to_items(remapped, client.offset_encoding)
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local make_entry = require("telescope.make_entry")
        local conf = require("telescope.config").values

        pickers
            .new({}, {
                prompt_title = "Definitions",
                finder = finders.new_table({
                    results = items,
                    entry_maker = make_entry.gen_from_quickfix({}),
                }),
                previewer = conf.qflist_previewer({}),
                sorter = conf.generic_sorter({}),
            })
            :find()
    end)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local keymap = vim.keymap
        local opts = { buffer = bufnr, silent = true }

        -- Treesitter captures drive color; LSP semantic tokens fight that model.
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end

        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>rf", vim.lsp.buf.format, opts)
        keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

        keymap.set("n", "gd", goto_definition, opts)
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
        keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
        keymap.set("n", "gs", "<cmd>Telescope lsp_document_symbols<cr>", opts)
        keymap.set("n", "gS", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
        keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)

        keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        keymap.set("n", "<leader>df", function()
            vim.diagnostic.jump({ count = 1 })
        end, opts)
        keymap.set("n", "<leader>dB", function()
            vim.diagnostic.jump({ count = -1 })
        end, opts)

        keymap.set("n", "<leader>rs", function()
            for server_name, is_available in pairs(lsp_servers) do
                if is_available() then
                    vim.lsp.enable(server_name, false)
                    vim.lsp.enable(server_name, true)
                end
            end
        end, opts)

        vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
            buffer = bufnr,
            callback = function(event)
                local enabled = event.event == "InsertLeave"

                vim.diagnostic.enable(enabled)
            end,
        })
    end,
})

for server_name, is_available in pairs(lsp_servers) do
    if is_available() then
        vim.lsp.enable(server_name)
    end
end

vim.diagnostic.config({
    signs = false,
    underline = true,
    virtual_text = false,
    virtual_lines = true,
    float = {
        source = true,
    },
    linehl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
        [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
    },
})
