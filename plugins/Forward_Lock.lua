do

local function pre_process(msg)
    
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_fwd'] then
                lock_fwd = data[tostring(msg.to.id)]['settings']['lock_fwd']
            end
        end
end

    local hash = 'mate:'..msg.to.id
    if redis:get(hash) and msg.fwd_from and not is_momod(msg) then
            delete_msg(msg.id, ok_cb, true)
            return ""
        end
    
        return msg
    end
local function run(msg, matches)
    channel_id = msg.to.id
    if matches[1] == 'lock' and is_momod(msg) then
                    local hash = 'mate:'..msg.to.id
                    redis:set(hash, true)
                    return ""
  elseif matches[1] == 'unlock' and is_momod(msg) then
                    local hash = 'mate:'..msg.to.id
                    redis:del(hash)
                    return ""
					end
end
end
return {
    patterns = {
    },
    run = run,
    pre_process = pre_process
}
end
