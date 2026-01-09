return {
    -- vesper
    { 
        'datsfilipe/vesper.nvim' 
    },

    -- nord
    -- {
    --     'shaunsingh/nord.nvim',
    -- },

    -- gruvbox
    -- { 
    --     "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = 'transparent_mode = false,' 
    -- },

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
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     ---@module "ibl"
    --     ---@type ibl.config
    --     config = function()
    --         require("ibl").setup({
    --             indent = {
    --                 highlight = { "Whitespace" },
    --             },
    --             scope = {
    --                 highlight = { "Label" },
    --             },
    --             exclude = {
    --                 filetypes = {
    --                     "dashboard",
    --                     "markdown",
    --                     "help",
    --                     "lazy"
    --                 },
    --                 buftypes = {
    --                     "terminal",
    --                     "nofile",
    --                     "quickfix",
    --                     "prompt"
    --                 },
    --             },
    --         })
    --     end,
    -- },

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
                    -- theme = 'gruvbox_dark',
                    -- theme = 'nord',
                    theme = 'vesper',
                },
                sections = {
                    lualine_c = {
                        { 'filename', path = 1 },
                    },
                },
            })
        end,
    },

    -- nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "vim", "lua", "markdown", "markdown_inline", 
                    "regex", "bash",
                },
                highlight = {
                    enable = true,
                },
            })
        end,
    },
    
    -- markdown.nvim
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        ft = { "markdown" }, -- Load on markdown files
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.treesitter.start()
                end,
            })
            
            require('render-markdown').setup({})
        end,
    },

    -- noice.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                lsp_doc_border = true, -- This helps with LSP docs
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- if you use nvim-cmp
                },
            },
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
                    width = {
                        max = 42,
                    },
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
    },
    
    -- hlchunk
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true
                },
                line_num = {
                    enable = true
                },
                indent = {
                    enable = true
                },
            })
        end
    },

    -- toggleterm (floating terminal)
    {
        'akinsho/toggleterm.nvim', version = "*", config = true
    },

    -- nvim-colorizer
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            vim.opt.termguicolors = true
            require("colorizer").setup()
        end
    }
}
