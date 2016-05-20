local function run(msg, matches)
local text = io.popen("whois "..matches[1]):read('*all')
  return text
end
return {
  patterns = {
    '^[!/#][Ww][Hh][Oo][Ii][Ss] (.*)$'
  },
  run = run,
  moderated = true
}
