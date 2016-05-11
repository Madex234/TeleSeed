function run(msg, matches)
if not is_sudo(msg) then
return 
end
text = io.popen("speedtest-cli --simple "):read('*all')
  return text
end
return {
  patterns = {
    '^[#/!]testsimple$'
  },
  run = run,
  moderated = true
}