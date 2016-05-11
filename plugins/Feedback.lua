do
 function run(msg, matches)
   local fuse = 'New Message\n➖➖➖➖➖➖➖➖➖➖➖➖\nName: ' .. msg.from.print_name ..'\nUsername: @' .. msg.from.username .. '\nID: ' .. msg.from.id .. '\nGroup Name: ' ..msg.to.title..'\nGroup ID: ' ..msg.to.id..'\n\nMessage:\n' .. matches[1]  
   local fuses = '!printf user#id' .. msg.from.id
   local text = matches[1]
   local channel = "channel#id"..1034936602 
   local sends = send_msg(channel, fuse, ok_cb, false)
  return 'Your Message Has Been Send To @iSepehr2001 ✅'
 end
 end
 return {
  description = "Feedback",
usage = {
  "ارسال نظرات انتقادات و پیشنهادات خود به سازنده ربات",
		  "دستور:",
          "/feedback [متن]",
	},  patterns = {
  "^[#!/][Ff]eedback (.*)$"
  },
  run = run
 }