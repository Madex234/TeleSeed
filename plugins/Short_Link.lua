local function run(msg, matches)
  local reza = URL.escape(matches[1])
  url = "https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl="..reza
  jstr, res = https.request(url)
  jdat = JSON.decode(jstr)
  if jdat.message then
    return 'Short Link:\n➖➖➖➖➖➖➖➖➖➖➖➖\n'..jdat.message
  else
	return "Orginal Link:\n"..jdat.data.long_url.."\n➖➖➖➖➖➖➖➖➖➖➖➖\nShort Link:\n"..jdat.data.url  
	end
  end

return {
usage = {
  "کوتاه کردن لینک مورد نظر",
		  "دستور:",
          "/shorten [لینک]",
	},
  patterns = {
  "^[/!#]shorten (.*)$"
  },
  run = run,
}