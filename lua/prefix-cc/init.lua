local M = {} 
    

local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1

  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  return string.sub(lines[1], s_start[3], s_end[3])
end

local function set_text_at_selection(text)
  local bufnr = vim.api.nvim_get_current_buf()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")

  vim.api.nvim_buf_set_text(bufnr, s_start[2] - 1, s_start[3] - 1, s_end[2] - 1, s_end[3], {text})
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end

  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')

  return s
end

function LookupPrefix(withPrefix)
  prefix = get_visual_selection()
  url = "prefix.cc/" .. prefix .. ".file.csv"
  result = os.capture("curl -f " .. url .. " 2> /dev/null; echo $?")

  lines = result:gmatch("%d+$")
  exitcode = lines()

  if exitcode ~= "0" then
    return 
  end

  csv = string.sub(result, 1, -2)

  out =  string.gmatch(csv, '"([^"]+)"')()
  if withPrefix then
    set_text_at_selection("@prefix " .. prefix .. ": <" .. out .. "> .")
  else
    set_text_at_selection(out)
  end

end

M.lookup = LookupPrefix

return M
