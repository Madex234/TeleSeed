local function run(msg, matches, callback, extra)

local data = load_data(_config.moderation.data)

local group_welcome = data[tostring(msg.to.id)]['group_welcome']

if matches[1] == 'delwlc' and not matches[2] and is_owner(msg) then 
    
   data[tostring(msg.to.id)]['group_welcome'] = nil --delete welcome
        save_data(_config.moderation.data, data)
        
        return 'SuperGroup Welcome Deleted!'
end
if not is_owner(msg) then 
    return 'For Owners Only!'
end
local rules = data[tostring(msg.to.id)]['rules']
    
if matches[1] == 'rules' and matches[2] and is_owner(msg) then
    if data[tostring(msg.to.id)]['rules'] == nil then --when no rules found....
        return 'No Rules Found!\n\nSet Rules First By /setrules [rules]\nOr\nSet Normal Welcome By /setwlc [welcome msg]'
end
data[tostring(msg.to.id)]['group_welcome'] = matches[2]..'\n\nSuperGroup Rules:\n'..rules
        save_data(_config.moderation.data, data)
        
        return 'SuperGroup Welcome Seted To:\n> '..matches[2]
end
if not is_owner(msg) then 
    return 'For Owners Only!'
end

if matches[1] and is_owner(msg) then
    
data[tostring(msg.to.id)]['group_welcome'] = matches[1]
        save_data(_config.moderation.data, data)
        
        return 'SuperGroup Welcome Seted To: \n> '..matches[1]
end
if not is_owner(msg) then 
    return 'For Owners Only!'
end


    
end
return {
usage = {
  "تنظیم کردن متن خوش آمدگویی برای گروه",
		  "دستور تنظیم کردن پیام خوش آمدگویی:",
          "/setwlc [پیام]",
		  "دستور تنظیم کردن پیام خوش آمدگویی به همراه قوانین:",
          "/setwlc rules [پیام]",
		  "دستور پاک کردن پیام خوش آمدگویی:",
          "/delwlc",
	},
  patterns = {
  "^[#!/]setwlc (rules) +(.*)$",
  "^[#!/]setwlc +(.*)$",
  "^[#!/](delwlc)$"
  },
  run = run
}