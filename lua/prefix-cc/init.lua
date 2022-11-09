local M = {} 

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

function LookupPrefix(prefix, withPrefix)
  url = "prefix.cc/" .. prefix .. ".file.csv"
  result = os.capture("curl -f " .. url .. " 2> /dev/null; echo $?")

  lines = result:gmatch("%d+$")
  exitcode = lines()

  if exitcode ~= "0" then
    return prefix
  end

  csv = string.sub(result, 1, -2)

  out =  string.gmatch(csv, '"([^"]+)"')()
  if withPrefix then
    return "@prefix " .. prefix .. ": <" .. out .. "> ."
  else
    return out
  end
end

M.lookup = LookupPrefix

return M
