do

local function run(msg, matches)
  if matches[1]:lower() == 'robot' and is_owner(msg) then
      return "TeleGuard Is Online And Ready For Protection Group ✅"
	  end
  if not is_owner(msg) then
	  return "For Owner Only!"
  end
  end
return {
  description = "Test Robot Online", 
usage = {
  "نمایش وضعیت ربات",
		  "دستور:",
          "/robot",
	},  patterns = {
	"^[#!/]([Rr]obot)$"
  }, 
  run = run 
}

end