return {
    -- nord
    {
        'shaunsingh/nord.nvim',
    },

    -- dashboard
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },

    -- gitsigns
    {
        'lewis6991/gitsigns.nvim'
    },

    -- indent-blankline
    {
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
    },

    -- lazygit
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'nord',
                },
                sections = {
                    lualine_c = {
                        { 'filename', path = 1 },
                    },
                },
            })
        end,
    },

    -- markdown.nvim
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

    -- noice.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },

    -- nvim-notify
    {
        'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                background_colour = "#000000",
            })
        end,
    },

    -- nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                view = {
                    adaptive_size = true,
                },
                filters = {
                    dotfiles = false,
                    exclude = {
                        "~/.config"
                    },
                },
                renderer = {
                    hidden_display = "all",
                    indent_markers = {
                        enable = true,
                        inline_arrows = false,
                    },
                },
                update_focused_file = {
                    enable = true,
                    update_root = {
                        enable = true,
                    },
                },
            })
        end,
    }
}
