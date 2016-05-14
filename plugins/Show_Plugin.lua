do
local function view_sura(channel_id, target)
	local f = io.open("./plugins/("..target..").lua","r")
	if f ~= nil then
		local text = f:read("*all")
		return text
	else
		return 'Plugin Not Found'
	end
end

local function run(msg, matches)
    local channel_id = msg.to.id
	if matches [1] == "show" and is_sudo(msg) then
		local file = io.open("./plugins/"..matches [2]..".lua", "r")
		local text = file:read("*all")
		return text
	end
end

return {
	patterns = {
		"^[!#/](show) (.+)$",
    }, 
	run = run,
	}
end
