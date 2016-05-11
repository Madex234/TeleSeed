local function temps(K)
	local F = (K*1.8)-459.67
	local C = K-273.15
	return F,C
end

local function run(msg, matches)
	local res = http.request("http://api.openweathermap.org/data/2.5/weather?q="..URL.escape(matches[2]).."&appid=269ed82391822cc692c9afd59f4aabba")
	local jtab = JSON.decode(res)
	if jtab.name then
		if jtab.weather[1].main == "Thunderstorm" then
			status = "طوفانی 🌪"
		elseif jtab.weather[1].main == "Drizzle" then
			status = "نم نم باران 🌧"
		elseif jtab.weather[1].main == "Rain" then
			status = "بارانی ⛈"
		elseif jtab.weather[1].main == "Snow" then
			status = "برفی 🌨"
		elseif jtab.weather[1].main == "Atmosphere" then
			status = "مه - غبار آلود 🌫"
		elseif jtab.weather[1].main == "Clear" then
			status = "صاف ☀️"
		elseif jtab.weather[1].main == "Clouds" then
			status = "ابری ☁️"
		elseif jtab.weather[1].main == "Extreme" then
			status = ""
		elseif jtab.weather[1].main == "Additional" then
			status = ""
		else
			status = ""
		end
		local F1,C1 = temps(jtab.main.temp)
		local F2,C2 = temps(jtab.main.temp_min)
		local F3,C3 = temps(jtab.main.temp_max)
		send_document(get_receiver(msg), "/root/TeleSeed/data/file/weatherIcon/"..jtab.weather[1].icon..".webp", ok_cb, false)
		if jtab.rain then
			rain = jtab.rain["3h"].." ميليمتر"
		else
			rain = ""
		end
		if jtab.snow then
			snow = jtab.snow["3h"].." ميليمتر"
		else
			snow = ""
		end
		today = "🌡 دمای هوا در "..jtab.name.."\n➖➖➖➖➖➖➖➖➖➖➖➖\n"
		..""..C1.."° درجه سانتیگراد\n"
		..""..F1.."° درجه فارنهايت\n"
		..""..jtab.main.temp.."° درجه کلوين\n"
		.."هم اکنون هوا "..status.." مي باشد\n➖➖➖➖➖➖➖➖➖➖➖➖\n"
		.."☄ بارندگي 3 ساعت اخير: "..rain.."\n"
		.."❄️ بارش برف 3 ساعت اخير: "..snow.."\n➖➖➖➖➖➖➖➖➖➖➖➖\n"
		.."🔻 حداقل دمای امروز:\n C"..C2.."°   F"..F2.."°   K"..jtab.main.temp_min.."°\n"
		.."🔺 حداکثر دماي امروز:\n C"..C3.."°   F"..F3.."°   K"..jtab.main.temp_max.."°\n➖➖➖➖➖➖➖➖➖➖➖➖\n"
		.."رطوبت هوا: "..jtab.main.humidity.."%\n"
		.."مقدار ابر آسمان: "..jtab.clouds.all.."%\n"
		.."سرعت باد: "..(jtab.wind.speed or "------").."m/s متر بر ثانيه\n"
		.."جهت باد: "..(jtab.wind.deg or "------").."° درجه\n"
		.."فشار هوا: "..(jtab.main.pressure/1000).." بار (اتمسفر)\n➖➖➖➖➖➖➖➖➖➖➖➖\n"
		after = ""
		local res = http.request("http://api.openweathermap.org/data/2.5/forecast?q="..URL.escape(matches[2]).."&appid=269ed82391822cc692c9afd59f4aabba")
		local jtab = JSON.decode(res)
		for i=1,5 do
			local F1,C1 = temps(jtab.list[i].main.temp_min)
			local F2,C2 = temps(jtab.list[i].main.temp_max)
			if jtab.list[i].weather[1].main == "Thunderstorm" then
				status = "طوفانی 🌪"
			elseif jtab.list[i].weather[1].main == "Drizzle" then
				status = "نم نم باران 🌧"
			elseif jtab.list[i].weather[1].main == "Rain" then
				status = "بارانی ⛈"
			elseif jtab.list[i].weather[1].main == "Snow" then
				status = "برفی 🌨"
			elseif jtab.list[i].weather[1].main == "Atmosphere" then
				status = "مه - غبار آلود 🌫"
			elseif jtab.list[i].weather[1].main == "Clear" then
				status = "صاف ☀️"
			elseif jtab.list[i].weather[1].main == "Clouds" then
				status = "ابری ☁️"
			elseif jtab.list[i].weather[1].main == "Extreme" then
				status = ""
			elseif jtab.list[i].weather[1].main == "Additional" then
				status = ""
			else
				status = ""
			end
			local file = io.open("/root/TeleSeed/data/file/weatherIcon/"..jtab.list[i].weather[1].icon..".char")
			if file then
				local file = io.open("/root/TeleSeed/data/file/weatherIcon/"..jtab.list[i].weather[1].icon..".char", "r")
				icon = file:read("*all")
			else
				icon = ""
			end
			if i == 1 then
				day = "فردا هوا "
			elseif i == 2 then
				day = "پس فردا هوا "
			elseif i == 3 then
				day = "3 روز بعد هوا "
			elseif i == 4 then
				day = "4 روز بعد هوا "
			elseif i == 5 then
				day = "5 روز بعد هوا "
			end
			after = after.."- "..day..status.." ميباشد. "..icon.."\n🔺C"..C2.."°  -  F"..F2.."°\n🔻C"..C1.."°  -  F"..F1.."°\n"
		end
		
		return today.."وضعيت آب و هوا در پنج روز آينده:\n"..after
	else
		return "Location Is Not Correct"
	end
end

return {
	description = "Weather Status",
usage = {
  "نمایش آب و هوای پیشرفته شهر مورد نظر",
		  "دستور:",
          "/weather [شهر]",
	},	patterns = {"^([[!#/]weather) (.*)$"},
	run = run,
}

-- https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20in%20%28select%20woeid%20from%20geo.places%281%29%20where%20text%3D%22"..URL.escape(matches[1]).."%22%29&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys
-- celsius = string.format("%.0f", (data.temp - 32) * 5/9)

-- jtab.weather[1].description		clear sky",
-- "مختصات جغرافيايي: "..jtab.coord.lon..","..jtab.coord.lat..""
-- jtab.list[i].weather.description		scattered clouds",
-- jtab.list[i].main.humidity