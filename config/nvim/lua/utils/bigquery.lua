local M = {}

-- Convert BigQuery tab-separated data to Markdown table
function M.to_markdown()
  -- Get the current selection or current line
  local start_line, end_line
  local mode = vim.fn.mode()

  if mode == 'v' or mode == 'V' then
    -- Visual mode
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
  else
    -- Normal mode - process from current line to end of paragraph
    start_line = vim.fn.line('.')
    end_line = start_line

    -- Find the end of the data block (empty line or end of file)
    local total_lines = vim.fn.line('$')
    while end_line < total_lines do
      local next_line = vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, false)[1]
      if next_line and next_line:match('^%s*$') then
        break
      end
      end_line = end_line + 1
    end
  end

  -- Get the lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local result = {}

  -- Process header
  if #lines > 0 then
    local header = vim.split(lines[1], '\t', {plain = true})
    table.insert(result, '| ' .. table.concat(header, ' | ') .. ' |')

    -- Create separator line
    local separator = '|'
    for _ = 1, #header do
      separator = separator .. ' --- |'
    end
    table.insert(result, separator)
  end

  -- Process data rows
  for i = 2, #lines do
    local cols = vim.split(lines[i], '\t', {plain = true})
    table.insert(result, '| ' .. table.concat(cols, ' | ') .. ' |')
  end

  -- Replace the lines with the markdown table
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
end

-- Setup function to create keymaps
function M.setup(opts)
  opts = opts or {}
  local prefix = opts.prefix or '<leader>bq'

  vim.keymap.set({'n', 'v'}, prefix, M.to_markdown, {desc = 'Convert BigQuery data to Markdown table'})
end

return M
