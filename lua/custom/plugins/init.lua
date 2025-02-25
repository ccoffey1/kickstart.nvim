-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'olrtg/nvim-emmet',
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    'rhysd/git-messenger.vim',
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
      render = 'virtual',
      ---Set virtual symbol (requires render to be set to 'virtual')
      virtual_symbol = '■',
      ---Highlight hex colors, e.g. '#FFFFFF'
      enable_hex = true,
      ---Highlight short hex colors e.g. '#fff'
      enable_short_hex = true,
      ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
      enable_rgb = true,
      ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
      enable_hsl = true,
      -- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
      enable_hsl_without_function = true,
      ---Highlight CSS variables, e.g. 'var(--testing-color)'
      enable_var_usage = true,
      ---Highlight named colors, e.g. 'green'
      enable_named_colors = true,
      ---Highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = true,
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-k>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-l>', function()
        harpoon:list():select(4)
      end)
    end,
  },
}
