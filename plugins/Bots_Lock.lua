
local function isBotAllowed (userId, channelId)
  local hash = 'anti-bot:allowed:'..ChannelId..':'..userId
  local banned = redis:get(hash)
  return banned
end

local function allowBot (userId, channelId)
  local hash = 'anti-bot:allowed:'..channelId..':'..userId
  redis:set(hash, true)
end

local function disallowBot (userId, chatId)
  local hash = 'anti-bot:allowed:'..channelId..':'..userId
  redis:del(hash)
end

-- Is anti-bot enabled on chat
local function isAntiBotEnabled (channelId)
  local hash = 'anti-bot:enabled:'..channelId
  local enabled = redis:get(hash)
  return enabled
end

local function enableAntiBot (channelId)
  local hash = 'anti-bot:enabled:'..channelId
  redis:set(hash, true)
end

local function disableAntiBot (channelId)
  local hash = 'anti-bot:enabled:'..channelId
  redis:del(hash)
end

local function isABot (user)
  -- Flag its a bot 0001000000000000
  local binFlagIsBot = 4096
  local result = bit32.band(user.flags, binFlagIsBot)
  return result == binFlagIsBot
end

local function isABotBadWay (user)
  local username = user.username or ''
  return username:match("[Bb]ot$")
end

local function kickUser(userId, channelId)
  local chat = 'channel#id'..channelId
  local user = 'user#id'..userId
  channel_del_user(channel, user, function (data, success, result)
    if success ~= 1 then
      print('I can\'t kick '..data.user..' but should be kicked')
    end
  end, {channel=channel, user=user})
end

local function run (msg, matches)

  -- We wont return text if is a service msg
  if matches[1] ~= 'channel_add_user' and matches[1] ~= 'channel_add_user_link' then
    if msg.to.type ~= 'chat' and msg.to.type ~= 'channel' then
      return 'Anti-flood works only on channels'
    end
  end

  local channelId = msg.to.id
  if matches[1] == 'enable' then
    enableAntiBot(channelId)
    return 'Anti-bot enabled on this chat'
  end
  if matches[1] == 'disable' then
    disableAntiBot(channelId)
    return 'Anti-bot disabled on this chat'
  end
  if matches[1] == 'allow' then
    local userId = matches[2]
    allowBot(userId, channelId)
    return 'Bot '..userId..' allowed'
  end
  if matches[1] == 'disallow' then
    local userId = matches[2]
    disallowBot(userId, channelId)
    return 'Bot '..userId..' disallowed'
  end
  if matches[1] == 'channel_add_user' or matches[1] == 'channel_add_user_link' then
    local user = msg.action.user or msg.from
    if isABotBadWay(user) then
      print('It\'s a bot!')
      if isAntiBotEnabled(channelId) then
        print('Anti bot is enabled')
        local userId = user.id
        if not isBotAllowed(userId, channelId) then
          kickUser(userId, channelId)
        else
          print('This bot is allowed')
        end
      end
    end
  end
end

return {
  description = 'When bot enters group kick it.',
  usage = {
    '!antibot enable: Enable Anti-bot on current chat',
    '!antibot disable: Disable Anti-bot on current chat',
    '!antibot allow <botId>: Allow <botId> on this chat',
    '!antibot disallow <botId>: Disallow <botId> on this chat'
  },
  patterns = {
    '^!antibot (allow) (%d+)$',
    '^!antibot (disallow) (%d+)$',
    '^!antibot (enable)$',
    '^!antibot (disable)$',
    '^!!tgservice (channel_add_user)$',
    '^!!tgservice (channel_add_user_link)$'
  },
  run = run
}
