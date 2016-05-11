do

local function run(msg, matches)
  if matches[1]:lower() == 'teleguard' or 'ver' then
    send_document(get_receiver(msg), "./data/me.webp", ok_cb, false)
      return [[
TeleGuard v4
An Advanced Administration Bot Based On TG-CLI Written In Lua
  
Admins:
@iSepehr2001 [Developer]
@ihossein7 [Admin]

Channel:
@TeleGuard_CH
  ]]
  end
end

return {
  description = "Shows bot version", 
usage = {
  "نمایش اطلاعاتی در مورد ربات",
		  "دستور:",
          "/ver",
		  "/TeleGuard",
	},  patterns = {
  "^[#!/]([Tt]ele[Gg]uard)",
  "^[#!/]([Vv]er)$"
  }, 
  run = run 
}

end