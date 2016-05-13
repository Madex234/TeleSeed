local function run(msg, matches)
if msg.to.type == 'channel' then
    if is_momod(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_eng'] then
                lock_eng = data[tostring(msg.to.id)]['settings']['lock_eng']
            end
        end
    end
    local channel = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_eng == "yes" then
		delete_msg(msg.id, ok_cb, true)
    end
end
 end
return {
    usage = {
  "قفل کردن صحبت به زبان انگلیسی",
		  "دستور قفل کردن:",
          "/lock english",
		  "دستور باز کردن:",
          "/unlock english",
	},
  patterns = {
    "[Aa]",
    "[Bb]",
    "[Cc]",
    "[Dd]",
    "[Ee]",
    "[Ff]",
    "[Gg]",
    "[Hh]",
    "[Ii]",
    "[Jj]",
    "[Kk]",
    "[Ll]",
    "[Mm]",
    "[Nn]",
    "[Oo]",
    "[Pp]",
    "[Qq]",
    "[Rr]",
    "[Ss]",
    "[Tt]",
    "[Uu]",
    "[Vv]",
    "[Ww]",
    "[Xx]",
    "[Yy]",
    "[Zz]",
  },
  run = run
}
