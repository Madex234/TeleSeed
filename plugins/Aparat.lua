local function run(msg, matches)
	if matches[1]:lower() == 'aparat' then
		local url = http.request('http://www.aparat.com/etc/api/videoBySearch/text/'..URL.escape(matches[2]))
		local jdat = json:decode(url)

		local items = jdat.videobysearch
		text = 'Search Results: \n'
		for i = 1, #items do
		text = text..'\n'..i..'- '..items[i].title..'  -  Number Of Visit: '..items[i].visit_cnt..'\n    Link: aparat.com/v/'..items[i].uid
		end
		return text
	end
end

return {
usage = {
  "جستجو در آپارات",
		  "دستور:",
          "/aparat [نام ویدیو]",
	},
   patterns = {
"^[#/!](aparat) (.*)$",
   },
   run = run
}