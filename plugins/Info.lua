function run(msg, matches)
  return "Fullname: "..(msg.from.first_name or '')..' '..(msg.from.last_name or '').."\nFirstname: "..(msg.from.first_name or '-----').."\nLastname: "..(msg.from.last_name or '-----').."\n\nGroup Name: "..msg.to.title.."\nGroup ID: "..msg.to.id.."\n\nID: "..msg.from.id.."\nUsername: Telegram.me/"..(msg.from.username or '')
end
return {
  description = "", 
usage = {
  "دریافت اطلاعاتی در مورد خود",
		  "دستور:",
          "/myinfo",
	},  patterns = {
    "^[!/#]myinfo$",
  },
  run = run
}