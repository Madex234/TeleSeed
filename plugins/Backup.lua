local function run(msg, matches)
if matches[1] == 'backup' and is_sudo(msg) then
    local cmd = io.popen('sudo tar -cpf TeleSeed.tar *')
      cmd:read('*all')
      cmd:close()
      send_document(msg.from.id, './TeleSeed.tar')
  end
  end
return {
patterns = {
"^[!#/]backup$",
},
run = run
}
