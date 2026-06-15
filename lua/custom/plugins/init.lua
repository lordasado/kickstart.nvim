-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tomorrow_night',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'filename', separator = ' ' }, { 'filetype', icon_only = true, padding = 0 } },
          lualine_c = { 'diff', 'diagnostics', 'overseer' },
          lualine_x = {
            {
              'aerial',
              -- The separator to be used to separate symbols in status line.
              sep = ' ) ',

              -- The number of symbols to render top-down. In order to render only 'N' last
              -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
              -- be used in order to render only current symbol.
              depth = nil,

              -- When 'dense' mode is on, icons are not rendered near their symbols. Only
              -- a single icon that represents the kind of current symbol is rendered at
              -- the beginning of status line.
              dense = false,

              -- The separator to be used to separate symbols in dense mode.
              dense_sep = '.',

              -- Color the symbol icons.
              colored = true,
            },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
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

    -- config = function()
    --   local presets = require('markview.presets').tables
    --
    --   require('markview').setup {
    --     markdown = {
    --       tables = presets.rounded,
    --     },
    --   }
    -- end,
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
      min_error_duration = 1.5, -- minimum seconds errors must exist before phonk triggers (0 = instant)
      block_input = false, -- block input during phonk/overlay
      dim_level = 20, -- phonk overlay darkness 0..100

      sound_enabled = true, -- enable sounds
      image_enabled = true, -- enable images (needs image.nvim)

      boom_volume = 20, -- volume for vine boom sound (0..100)
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
        suppress_deprecation = true,
      },
    },
  },
  {
    'stevearc/overseer.nvim',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    config = function()
      require('overseer').setup {
        vim.api.nvim_create_user_command('OverseerRestartLast', function()
          local overseer = require 'overseer'
          local task_list = require 'overseer.task_list'
          local tasks = overseer.list_tasks {
            status = {
              overseer.STATUS.SUCCESS,
              overseer.STATUS.FAILURE,
              overseer.STATUS.CANCELED,
            },
            sort = task_list.sort_finished_recently,
          }
          if vim.tbl_isempty(tasks) then
            vim.notify('No tasks found', vim.log.levels.WARN)
          else
            local most_recent = tasks[1]
            overseer.run_action(most_recent, 'restart')
          end
        end, {}),

        templates = { 'builtin' },

        vim.keymap.set('n', '<leader>oo', '<cmd>OverseerRun<CR>', { desc = 'Overseer: Run' }),
        vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<CR>', { desc = 'Overseer: [t]oggle' }),
        vim.keymap.set('n', '<leader>ol', '<cmd>OverseerRestartLast<CR>', { desc = 'Overseer: Restart [l]ast Task' }),
      }
    end,
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
        layout = {
          default_direction = 'prefer_left',
        },
        close_on_select = true,
        float = {
          relative = 'win',
        },
        filter_kinds = false,
        focus_on_open = true,
        nav = {
          autojump = true,
          preview = true,
          keymaps = {
            ['q'] = 'actions.close',
          },
        },

        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
      }
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>aa', '<cmd>AerialNavToggle<CR>', { desc = 'Aerial: Toggle Nav' })
      vim.keymap.set('n', '<leader>af', '<cmd>AerialToggle float<CR>', { desc = 'Aerial: Toggle [f]loat' })
      vim.keymap.set('n', '<leader>ae', '<cmd>AerialToggle!<CR>', { desc = 'Aerial: Toggle Sid[e]bar' })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        javascript = { 'oxlint' },
        javascriptreact = { 'oxlint' },
        typescript = { 'oxlint' },
        typescriptreact = { 'oxlint' },
        svelte = { 'oxlint' },
        astro = { 'oxlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    -- To avoid being surprised by breaking changes,
    -- I recommend you set a version range
    version = '^9',
    -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
    -- No need for lazy.nvim to lazy-load it.
    lazy = false,
  },
}
