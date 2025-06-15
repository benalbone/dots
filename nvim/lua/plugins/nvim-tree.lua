return {
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
