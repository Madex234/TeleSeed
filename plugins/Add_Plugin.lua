local function run(msg, matches)
  local text = matches[1]
  local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
    if not is_sudo(msg)then
    return 'Add Plugins Only By Sudo'
  end
  local name = matches[2]
  local file = io.open("./plugins/"..name, "w")
  file:write(text)
  file:flush()
  file:close()
  return "Plugin Was Successfully Added"
 end
 return {
  description = "a Usefull plugin for sudo !",
usage = {
  "افزودن یک پلاگین جدید به ربات",
		  "دستور:",
          "/addplug",
	},
patterns = {
    "^[/#!]addplug (.+) (.*)$"
  },
  run = run
}