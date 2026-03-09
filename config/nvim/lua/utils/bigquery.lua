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

  if #lines == 0 then
    return
  end

  -- First pass: collect all rows with backticks and calculate max widths
  local rows = {}
  local max_widths = {}

  for line_idx, line in ipairs(lines) do
    local cols = vim.split(line, '\t', {plain = true})
    rows[line_idx] = {}

    for col_idx, col in ipairs(cols) do
      -- Wrap each cell in backticks
      local cell = '`' .. col .. '`'
      rows[line_idx][col_idx] = cell

      -- Track maximum width for this column
      max_widths[col_idx] = math.max(max_widths[col_idx] or 0, #cell)
    end
  end

  -- Second pass: build the formatted table
  local result = {}

  -- Header row (first row)
  if rows[1] then
    local header_parts = {}
    for col_idx, cell in ipairs(rows[1]) do
      local padded = cell .. string.rep(' ', max_widths[col_idx] - #cell)
      table.insert(header_parts, padded)
    end
    table.insert(result, '| ' .. table.concat(header_parts, ' | ') .. ' |')

    -- Separator row
    local sep_parts = {}
    for col_idx = 1, #max_widths do
      table.insert(sep_parts, string.rep('-', max_widths[col_idx]))
    end
    table.insert(result, '| ' .. table.concat(sep_parts, ' | ') .. ' |')
  end

  -- Data rows (remaining rows)
  for row_idx = 2, #rows do
    local row_parts = {}
    for col_idx, cell in ipairs(rows[row_idx]) do
      local padded = cell .. string.rep(' ', max_widths[col_idx] - #cell)
      table.insert(row_parts, padded)
    end
    table.insert(result, '| ' .. table.concat(row_parts, ' | ') .. ' |')
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
