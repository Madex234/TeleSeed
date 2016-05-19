do
local function save_value(msg, name, value)
  if (not name or not value) then
    return "Usage: !set var_name value"
  end
  local hash = nil
  if msg.to.type == 'channel' then
    hash = 'channel:'..msg.to.id..':variables'
  end
  if hash then
    redis:hset(hash, name, value)
    return "New Command Successfully Added To Getlist:\n> "..name
  end
end

local function get_variables_hash(msg)
  if msg.to.type == 'channel' then
    return 'channel:'..msg.to.id..':variables'
  end
end 

local function list_variables_channel(msg)
  local hash = get_variables_hash(msg)
  if hash then
    local names = redis:hkeys(hash)
    local text = 'Getlist:\n➖➖➖➖➖➖➖➖➖➖➖➖\n'
    for i=1, #names do
      text = text..'> '..names[i]..'\n'
    end
    return text
  else
  return 
  end
end

local function get_value(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return
    else
      return value
    end
  end
end

local function del_value(msg, name)
  if not name then
    return 
  end
  local hash = nil
  if msg.to.type == 'chat' or 'channel' then
    hash = 'channel:'..msg.to.id..':variables'
  end
  if hash then
    redis:del(hash, name)
  return '['..name..']  Deleted'
  end
end
local function run(msg, matches)
if matches[1]:lower() == 'set' then
  if not is_momod(msg) then
    return "For moderators only"
  end
  local name = string.sub(matches[2], 1, 50)
  local value = string.sub(matches[3], 1, 1000)
  local text = save_value(msg, name, value)
  return text
end
if matches[1]:lower() == 'rem' then
  if not is_momod(msg) then
    return "For moderators only"
  end
  local name = string.sub(matches[2], 1, 50)
  local text = del_value(msg, name)
  return text
end
if matches[1]:lower() == 'getlist' then
return list_variables_channel(msg)
elseif matches[1] == '!' or '/' or '#' then
  if matches[2] then
    local name = user_print_name(msg.from)
    return get_value(msg, matches[2])
  else
    return
  end
end
end

return {
	patterns = {
	"^[#!/]([Ss]et) ([^%s]+) (.+)$",
	"^[#!/]([Rr]em) (.+)$",
	"^[#!/]([Gg]etlist)$",
  "^([!#/])(.+)$",
  }, 
  run = run 
}
end
