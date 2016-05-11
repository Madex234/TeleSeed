function run(msg, matches)
if not is_sudo(msg) then
return 
end
text = io.popen("speedtest-cli --share "):read('*all')
  return text
end
return {
  patterns = {
    '^[#/!]testshare$'
  },
  run = run,
  moderated = true
}