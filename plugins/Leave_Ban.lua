local function run(msg, matches)
	local data = load_data(_config.moderation.data)
	if msg.action and msg.action.type then
	local action = msg.action.type 
    if data[tostring(msg.to.id)] then
		if data[tostring(msg.to.id)]['settings'] then
			if data[tostring(msg.to.id)]['settings']['leave_ban'] then 
				leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
			end
		end
    end
	if action == 'channel_del_user' and not is_momod2(msg.action.user.id) and leave_ban == 'yes' then
			local user_id = msg.action.user.id
			local channel_id = msg.to.id
			ban_user(user_id, channel_id)
		end
	end
end


return {
  patterns = {
    "^!!tgservice (.*)$"
  },
  run = run
}
