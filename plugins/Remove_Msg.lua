local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'" Messages Was Deleted', ok_cb, false)
  else
    send_msg(extra.chatid, 'The Number Of Your Messages Deleted', ok_cb, false)
  end
end
local function run(msg, matches)
  if matches[1] == 'rmsg' and is_owner(msg) then
    if msg.to.type == 'channel' then
      if tonumber(matches[2]) > 10000 or tonumber(matches[2]) < 1 then
        return "Wrong Number, Rang is [1-10000]"
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return "Only On SuperGroup"
    end
  else
    return "You Don't Have Access!"
  end
end

return {
usage = {
  "پاک کردن تعداد پیام مورد نظر در سوپرگروه",
		  "دستور:",
          "/rmsg [تعداد]",
	},
    patterns = {
        '^[!/#](rmsg) (%d*)$'
    },
    run = run
}