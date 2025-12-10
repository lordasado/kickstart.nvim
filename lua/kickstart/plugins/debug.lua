-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add virtual text support for DAP
    'theHamsta/nvim-dap-virtual-text',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<leader>d',
      group = 'Debugger',
      name = '+Debug: Debugger',
      nowait = true,
      remap = false,
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },

    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },

    {
      '<leader>dC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Debug: Run to Cursor',
    },

    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
      nowait = true,
      remap = false,
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
      nowait = true,
      remap = false,
    },
    {
      '<leader>du',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'Debug: Open REPL',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last',
      nowait = true,
      remap = false,
    },

    {
      '<leader>dq',
      function()
        require('dap').terminate()
        require('dapui').close()
        require('nvim-dap-virtual-text').toggle()
      end,
      desc = 'Debug: Terminate',
      nowait = true,
      remap = false,
    },

    {
      '<leader>dB',
      function()
        require('dap').list_breakpoints()
      end,
      desc = 'Debug: List Breakpoints',
      nowait = true,
      remap = false,
    },
    {
      '<leader>de',
      function()
        require('dap').set_exception_breakpoints { 'all' }
      end,
      desc = 'Debug: Set Exception Breakpoints',
      nowait = true,
      remap = false,
    },
    {
      '<leader>ds',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>dU',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dap_virtual_text = require 'nvim-dap-virtual-text'

    -- Dap Virtual Text
    dap_virtual_text.setup()

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'codelldb',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#f38ba8' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#f9e2af' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
