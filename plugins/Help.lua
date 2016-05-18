do

local function run(msg, matches)
  if matches[1]:lower() == 'help' then
      return [[راهنمای ربات TeleGuard:
➖➖➖➖➖➖➖➖➖➖➖➖
1. تمامی دستورات با # , / , ! می باشد.

2. برای مشاهده مشخصات ربات از دستور ver استفاده کنید.

3. در لیست کامندها (دستورات) محتویات داخل پرانتز، متغییرها هستند و نباید موقع ارسال دستور نیز از پرانتز استفاده کنید.

4. ربات ریپورت است، برای استفاده از همه ی قابلیتهای آن شماره ربات را ذخیره کنید.

5. برای دریافت فایل کامل راهنما از دستور <help/ استفاده کنید.
➖➖➖➖➖➖➖➖➖➖➖➖
📢 @TeleGuard_Ch
👤 @iSepehr2001
👤 @H0wssein
 ]]
  end
  if not is_owner(msg) then
	  return "For Owner Only!"
	  end
end

return {
  description = "Shows bot help", 
usage = {
  "نمایش لیست راهنما",
		  "دستور:",
          "/help",
	},  patterns = {
	"^[#!/]([Hh]elp)$"
  }, 
  run = run 
}

end
