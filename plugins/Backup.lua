function run(msg, matches)
if not is_sudo(msg) then
return 
end
text = io.popen('sudo tar -cpf TeleSeed.tar *'):read('*all')
  return text
end
return {
  patterns = {
    '^[#/!]backup$'
  },
  run = run,
  moderated = true
}
