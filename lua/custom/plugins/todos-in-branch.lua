local function show_todos_for_current_branch()
  local base_branch = vim.fn.system "git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"
  base_branch = vim.fn.trim(base_branch) -- Remove any trailing newline

  local fork_point = vim.fn.system('git merge-base --fork-point ' .. base_branch .. ' $(git rev-parse --abbrev-ref HEAD)')
  fork_point = vim.fn.trim(fork_point)

  if fork_point == '' then
    print 'Error: Unable to determine fork point.'
    return
  end

  local diff_output = vim.fn.system('git diff ' .. fork_point .. " $(git rev-parse --abbrev-ref HEAD) | grep '^+.*TODO'")
  diff_output = vim.fn.trim(diff_output)

  if diff_output == '' then
    print 'No TODOs found in the current branch.'
  else
    -- Create a new split and open a scratch buffer
    vim.cmd 'vsplit'
    local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe') -- Automatically wipe buffer when closed
    vim.api.nvim_win_set_buf(0, buf) -- Set the buffer to the current window

    -- Write the diff output to the buffer
    local lines = vim.split(diff_output, '\n', { trimempty = true })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Set filetype to git to enable syntax highlighting
    vim.api.nvim_buf_set_option(buf, 'filetype', 'git')
  end
end

vim.api.nvim_create_user_command('ShowTodosForCurrentBranch', show_todos_for_current_branch, {})
vim.keymap.set('n', '<leader>ct', ':ShowTodosForCurrentBranch<CR>', { desc = 'Show [T]odos for current branch' })

return {}
