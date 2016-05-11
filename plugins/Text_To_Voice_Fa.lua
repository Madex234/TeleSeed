local function run(msg, matches)
  local eq = matches[1]

  local url = "http://www.farsireader.com/PlayText.aspx?Text="..URL.escape(eq).."&Punc=false"
  local receiver = get_receiver(msg)
  local file = download_to_file(url,'text.ogg')
  send_audio('channel#id'..msg.to.id, file, ok_cb , false)
end

return {
  description = "Convert text to voice",
  usage = {
  "تبدیل متن فارسی خود به صدا",
		  "دستور:",
          "/voicefa [متن]",
	},
  patterns = {
    "^[!#/]voicefa (.+)$"
  },
  run = run
}