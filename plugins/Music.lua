local function musiclink(msg, musicid)
	local value = redis:hget('music:'..msg.to.id, musicid)
	if not value then
		return
	else
		value = value..'\n\n'
		return value
	end
end

------------------ Seconds To Minutes alg ------------------
function sectomin (Sec)
if (tonumber(Sec) == nil) or (tonumber(Sec) == 0) then
return "00:00"
else
Seconds = math.floor(tonumber(Sec))
if Seconds < 1 then Seconds = 1 end
Minutes = math.floor(Seconds / 60)
Seconds = math.floor(Seconds - (Minutes * 60))
if Seconds < 10 then
Seconds = "0"..Seconds
end
if Minutes < 10 then
Minutes = "0"..Minutes
end
return Minutes..':'..Seconds
end
end

function run(msg, matches)
	if string.match(msg.text, '[\216-\219][\128-\191]') then
		return send_large_msg(get_receiver(msg), 'Persian Not Support!\nUse English/Finglish')
	end
	if matches[1]:lower() == "dl" then
		local value = redis:hget('music:'..msg.to.id, matches[2])
		if not value then
			return 'Music Not Found!'
		else
			value = value..'\n\n'
			return value
		end
		return
	end
	
	local url = http.request("http://api.gpmod.ir/music.search/?q="..URL.escape(matches[2]).."&count=30&sort=2")
	
        --[[
	-- Sort order: 
	-- 1 — by duration 
	-- 2 — by popularity 
	-- 0 — by date added
	---
	-- max counts = 300
	]]
	local jdat = json:decode(url)
	local text , time , num = ''
	local hash = 'music:'..msg.to.id
	redis:del(hash)
	if #jdat.response < 2 then return "No Result Found." end
		for i = 2, #jdat.response do
			if 900 > jdat.response[i].duration then
			num = i - 1
			time = sectomin(jdat.response[i].duration)
			text = text..num..'- Artist: '.. jdat.response[i].artist .. ' | '..time..'\nTitle: '..jdat.response[i].title..'\n\n'
			redis:hset(hash, num, 'Artist: '.. jdat.response[i].artist .. '\nTitle: '..jdat.response[i].title..' \nTime: '..time..'\n➖➖➖➖➖➖➖➖➖➖➖➖\n'.."Download Link:\nGPMod.ir/dl.php?q="..jdat.response[i].owner_id.."_"..jdat.response[i].aid)
			end
		end
		text = text..'➖➖➖➖➖➖➖➖➖➖➖➖\nUse The Following Command To Download.\n/dl <number>\nExp: /dl 1'
	return text
end

return {
usage = {
  "جستجو و دانلود آهنگ مورد نظر",
		  "دستور:",
          "/music [نام خواننده]",
          "/dl [شماره آهنگ]",
	},
patterns = {
	"^[#/!]([Mm][Uu][Ss][Ii][Cc]) (.*)$",
	"^[#/!]([dD][Ll]) (.*)$"
	}, 
	run = run 
}

