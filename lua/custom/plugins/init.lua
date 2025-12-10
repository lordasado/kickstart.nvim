-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {}
    end,
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,

    -- For `nvim-treesitter` users.
    priority = 49,

    -- For blink.cmp's completion
    -- source
    -- dependencies = {
    --     "saghen/blink.cmp"
    -- },
  },
  {
    'Civitasv/cmake-tools.nvim',
    opts = {},
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    modes = {
      preview_float = {
        mode = 'diagnostics',
        preview = {
          type = 'float',
          relative = 'editor',
          border = 'rounded',
          title = 'Preview',
          title_pos = 'center',
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    },
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'folke/sidekick.nvim',
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = 'zellij',
          enabled = true,
        },
        win = {
          split = {
            width = 60,
            height = 20,
          },
        },
      },
    },
	-- stylua: ignore
    keys = {
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<c-.>',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select()
        end,
        -- Or to select only installed tools:
		function()
			require('sidekick.cli').select { filter = { installed = true } }
		end,
        desc = 'Select CLI',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send { msg = '{this}' }
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send { msg = '{file}' }
        end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
      -- Example of a keybinding to open Claude directly
      {
        '<leader>ac',
        function()
          require('sidekick.cli').toggle { name = 'claude', focus = true }
        end,
        desc = 'Sidekick Toggle Claude',
      },
    },
  },
  {
    'zbirenbaum/copilot.lua',
    -- requires = {
    --   'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
    -- },
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {}
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    '3rd/image.nvim',
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = 'magick_cli',
      max_width = 800,
      integrations = {
        markdown = {
          enabled = false,
        },
      },
    },
  },
  {
    'sahaj-b/brainrot.nvim',
    event = 'VeryLazy',
    opts = {
      -- defaults:

      disable_phonk = false, -- skip phonk/overlay on "no errors"
      phonk_time = 1.0, -- seconds the phonk/image overlay stays
      min_error_duration = 0.5, -- minimum seconds errors must exist before phonk triggers (0 = instant)
      block_input = false, -- block input during phonk/overlay
      dim_level = 20, -- phonk overlay darkness 0..100

      sound_enabled = true, -- enable sounds
      image_enabled = true, -- enable images (needs image.nvim)

      boom_volume = 50, -- volume for vine boom sound (0..100)
      phonk_volume = 20, -- volume for phonk sound (0..100)

      boom_sound = nil, -- custom boom sound path (e.g., "~/sounds/boom.ogg")
      phonk_dir = nil, -- custom phonk folder path (e.g., "~/sounds/phonks")
      image_dir = nil, -- custom image folder path (e.g., "~/memes/images")

      lsp_wide = false, -- track errors workspace-wide(get ALL lsp errors)
    },
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = { -- set to setup table
      user_default_options = {
        oklch_fn = true,
        rgb_fn = true,
        hsl_fn = true,
        -- Highlighting mode.  'background'|'foreground'|'virtualtext'
        mode = 'virtualtext',
        virtualtext = '■',
        virtualtext_inline = 'before',
        virtualtext_mode = 'foreground',
        tailwind = true,
        tailwind_opts = { -- Options for highlighting tailwind names
          update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
        },
      },
    },
  },
  {
    'stevearc/overseer.nvim',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      label = {
        rainbow = {
          enabled = true,
          -- number between 1 and 9
          shade = 3,
        },
      },
      modes = {
        search = {
          enabled = true,
          highlight = { backdrop = true },
        },
      },
    },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {
      foldKeymaps = {
        setup = false, -- modifies `h`, `l`, `^`, and `$`
      },
      foldtext = {
        lineCount = {
          template = ' %d',
        },
      },
      gitsignsCount = true,
    }, -- needed even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99

      -- local fold_util = require 'utils.code_folds'
      --
      -- vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'LspAttach' }, {
      --   callback = function(opts)
      --     fold_util.update_ranges(opts.buf)
      --   end,
      -- })

      -- local last_row = nil
      -- vim.api.nvim_create_autocmd('CursorMoved', {
      --   callback = function(opts)
      --     local row = vim.api.nvim_win_get_cursor(0)[1]
      --     if row ~= last_row then
      --       last_row = row
      --
      --       fold_util.update_current_fold(row, opts.buf)
      --     end
      --   end,
      -- })
      --
      -- vim.api.nvim_create_autocmd({ 'BufUnload', 'BufWipeout' }, {
      --   callback = function(opts)
      --     fold_util.clear(opts.buf)
      --   end,
      -- })

      -- vim.opt.statuscolumn = '%!v:lua.StatusCol()'
      -- vim.opt.statuscolumn = [[%s%=%{v:lua.require'utils.code_folds'.statuscol_fold()}%l  ]]
      -- function _G.StatusCol()
      --   return fold_util.statuscol()
      -- end
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('aerial').setup {
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
      }
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>A', '<cmd>AerialToggle!<CR>')
    end,
  },
}
