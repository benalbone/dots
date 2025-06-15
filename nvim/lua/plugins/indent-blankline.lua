return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    config = function()
        require("ibl").setup({
            indent = {
                highlight = { "Whitespace" },
            },
            scope = {
                highlight = { "Label" },
            },
            exclude = {
                filetypes = {
                    "dashboard",
                    "markdown",
                    "help",
                    "lazy"
                },
                buftypes = {
                    "terminal",
                    "nofile",
                    "quickfix",
                    "prompt"
                },
            },
        })
    end,
}
