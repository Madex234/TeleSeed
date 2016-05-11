do
 local function save_file(name, text)
    local file = io.open("./data/"..name, "w")
    file:write(text)
    file:flush()
    file:close()
end   
function run(msg, matches)
  if matches[1] == "makefile" and is_sudo(msg) then
 
         local name = matches[2]
        local text = matches[3]
        return save_file(name, text)
    end
   end
return {
usage = {
  "ساهت و دریافت فایل دلخواه در سرور",
		  "دستور:",
          "/makefile [فرمت] [متن]",
	},
  patterns = {
  "^[#/!](makefile) ([^%s]+) (.+)$"
  },
  run = run
}
end
