return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("todo-comments").setup({
            signs = false,
            keywords = {
                FIXME = {
                    icon = " ",
                    color = "error",
                    alt = { "BUG" },
                },
                TODO = {
                    icon = " ",
                    color = "info",
                    alt = { "TODO" },
                },
                PICKUP = {
                    icon = "喇",
                    color = "warning",
                },
                NOTE = {
                    alt = { "IMPORTANT" },
                },
            },
            highlight = {
                multiline = false,
                before = "fg",
                keyword = "bg",
                after = "fg",
                pattern = [[(KEYWORDS)]],
                comments_only = true,
                exclude = {},
            },
            colors = {
                error = { "DiagnosticError", "ErrorMsg" },
                warning = { "DiagnosticWarning", "WarningMsg" },
                info = { "Comment" },
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                pattern = [[\b(KEYWORDS)]],
            },
        })

        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>")
    end,
}
