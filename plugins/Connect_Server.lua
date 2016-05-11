local function run(msg, matches)
local text = io.popen(matches[1]):read('*all')
if is_sudo(msg) then
  return text
end
  end
return {
  patterns = {
    '^[#/!]sh (.*)$'
  },
  run = run,
  moderated = true
}
