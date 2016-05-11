do

function run(msg, matches)
       if not is_owner(msg) then
        return "For Owner Only!"
       end
    local data = load_data(_config.moderation.data)
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
       if not group_link then 
        return "First use /newlink Or If Bot Isn't Creator Use /setlink"
       end
         local text = "SuperGroup Link:\n"..group_link
          send_large_msg('user#id'..msg.from.id, text.."\n", ok_cb, false)
           return "SuperGroup Link Sent On Your Private"
end

return {
usage = {
  "دریافت لینک در pv",
		  "دستور:",
          "/linkpv",
	},
	patterns = {
    "^[/#!]([Ll]inkpv)$"
  },
  run = run
}

end