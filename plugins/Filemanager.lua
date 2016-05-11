do

local function run(msg, matches)
  if matches[1] == "sendfile" and matches[2] and matches[3] then
  if not is_sudo(msg) then
      return "For Sudo Only!"
      end  
  if is_sudo(msg) then
	    local file = "./"..matches[2].."/"..matches[3]..""
      local receiver = get_receiver(msg)
      send_document(receiver, file, ok_cb, false)
    end
  end
end

return {
usage = {
  "دانلود فایل دلخواه از سرور",
		  "دستور:",
          "/sendfile [نام فایل] [نام پوشه]",
	},
  patterns = {
  "^[!#/](sendfile) (.*) (.*)$"
  },
  run = run
}
end