do
local function run(msg, matches)
  if matches[1]:lower() == 'ip' then
      return [[
For View Your IP, Visit The Link Below
http://whatismyipaddress.com
  ]]
  end
end

return {
  description = "Shows ip", 
usage = {
  "نمایش ip خود",
		  "دستور:",
          "/ip",
	},  patterns = {
  "^[#!/]([Ii]p)$"
  }, 
  run = run 
}

end