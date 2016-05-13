local function run(msg, matches)
if msg.to.type == 'channel' then
    if is_momod(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_poker'] then
                lock_poker = data[tostring(msg.to.id)]['settings']['lock_poker']
            end
        end
    end
    local channel = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_poker == "yes" then
		delete_msg(msg.id, ok_cb, true)
    end
end
 end
return {
    usage = {
  "قفل کردن ارسال فرستادن اموجی پوکرفیس",
		  "دستور قفل کردن:",
          "/lock poker",
		  "دستور باز کردن:",
          "/unlock poker",
	},
  patterns = {
	"😐",
	"😑"
  },
  run = run
}
