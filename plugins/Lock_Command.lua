local function run(msg, matches)
if msg.to.type == 'channel' then
    if is_momod(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_cmd'] then
                lock_cmd = data[tostring(msg.to.id)]['settings']['lock_cmd']
            end
        end
    end
    local channel = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_cmd == "yes" then
		delete_msg(msg.id, ok_cb, true)
    end
end
end
return {
patterns = {
    "id",
    "help",
    "ban",
    "kick",
    "^/",
    "^!",
    "start"
  },
  run = run
}
