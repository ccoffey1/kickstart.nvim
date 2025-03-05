local function execute_in_current_directory()
  local current_file_dir = vim.fn.expand '%:p:h'
  local command = vim.fn.input 'Enter a command: '
  if command == '' then
    return
  end
  local cmd = 'cd ' .. current_file_dir .. ' && ' .. command
  vim.cmd('!' .. cmd)
end

vim.api.nvim_create_user_command('ExecuteCmdInCurrentDirectory', execute_in_current_directory, {})
vim.keymap.set('n', '<leader>e', ':ExecuteCmdInCurrentDirectory<CR>', { desc = '[E]xecute in current directory' })

return {}
