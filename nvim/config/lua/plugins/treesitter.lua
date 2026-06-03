return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local parsers = {
            "typescript",
            "javascript",
            "lua",
            "html",
            "css",
            "prisma",
            "yaml",
            "toml",
            "tsx",
            "markdown",
            "json",
            "dockerfile",
            "bash",
            "vim",
            "gitignore",
            "vimdoc",
            "go",
            "gomod",
            "gosum",
            "templ",
        }

        require("nvim-treesitter").setup()

        -- Install any parsers not already present (async, no-op if installed).
        require("nvim-treesitter").install(parsers)

        -- Map parser names -> filetypes so we only start TS on relevant buffers.
        local ts_filetypes = {}
        for _, lang in ipairs(parsers) do
            for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
                table.insert(ts_filetypes, ft)
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = ts_filetypes,
            callback = function()
                -- Highlighting
                pcall(vim.treesitter.start)
                -- Treesitter-based indentation (experimental)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
