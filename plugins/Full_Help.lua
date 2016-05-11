do

local function run(msg, matches)
  if matches[1]:lower() == 'help>' then
    send_document(get_receiver(msg), "./data/Help.htm", ok_cb, false)
      return 
end
end
return {
  description = "Shows bot version", 
usage = {
  "نمایش لیست راهنما در قالب یک فایل html",
		  "دستور:",
          "/help>",
	},  patterns = {
  "^[!#/](help>)",
  }, 
  run = run 
}

end