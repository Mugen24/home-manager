{config, pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraConfig = '' 
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set number
      lua << EOF
        vim.g.leader = <Space>
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = dracula-nvim;
        type = "lua";
        config = "
          vim.cmd[[colorscheme dracula]]
        ";
      }
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup({
            ensure_installed = "all",
            parser_install_dir = "~/.config/nvim",
            highlight = {
              enable = true,
            },
          })
        '';
      }
      {
        # Shows line indent
        plugin = indent-blankline-nvim;
        type = "lua";
        config = '' 
          local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
          }

          local hooks = require "ibl.hooks"
          -- create the highlight groups in the highlight setup hook, so they are reset
          -- every time the colorscheme changes
          hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
              vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
              vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
              vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
              vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
              vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
              vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
              vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
          end)

          require("ibl").setup { indent = { highlight = highlight } }
        '';
      }

      {
        plugin = plenary-nvim;
        type = "lua";
        # config = '' ''
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          -- Find files
          vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
          -- Find string in Files
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        '';
      }

      {
        plugin = rainbow-delimiters-nvim;
        type = "lua";
        # config = '' ''
      }

      # LSP setup
      {
        plugin = mason-nvim;
        type = "lua";
        config = ''
          require("mason").setup()
        '';
      }

      {
        plugin = mason-lspconfig-nvim;
        type = "lua";
        config = ''
          require("mason-lspconfig").setup()
          require("mason-lspconfig").setup_handlers({
              -- The first entry (without a key) will be the default handler
              -- and will be called for each installed server that doesn't have
              -- a dedicated handler.
              function (server_name) -- default handler (optional)
                  require("lspconfig")[server_name].setup {}
              end
          })
        '';
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        # config = '' ''
      }

      # Linter
      {
        plugin = nvim-lint;
        type = "lua";
        config = ''
        require('lint').linters_by_ft = {
          nix = {'nix'},
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          callback = function()
            -- try_lint without arguments runs the linters defined in `linters_by_ft`
            -- for the current filetype
            require("lint").try_lint()
          end,
        })
        '';
      }

    ];

    extraPackages = [
      pkgs.gcc 
      pkgs.curl
      pkgs.git
      pkgs.cargo
    ];
  };
}

# Plugins that might be interesting
# trouble.nvim: list all errors in a sidebar

