do
local function run(msg, matches)
	local lat = matches[2]
	local lon = matches[3]
	local receiver = get_receiver(msg)
	if matches[1] == "loc" then
		send_location(receiver, lat, lon, ok_cb, false)
	elseif matches[1] == "map" then
		local zooms = {10, 16}
		local urls = {}
		for i = 1, #zooms do
			local zoom = zooms[i]
			local url = "http://maps.googleapis.com/maps/api/staticmap?zoom=" .. zoom .. "&size=600x300&maptype=roadmap&center=" .. lat .. "," .. lon .. "&markers=color:blue%7Clabel:X%7C" .. lat .. "," .. lon
			table.insert(urls, url)
		end
		send_photos_from_url(receiver, urls)
	elseif matches[1] == "view" then
		local zooms = {12, 18}
		local urls = {}
		for i = 1, #zooms do
			local zoom = zooms[i]
			local url = "http://maps.googleapis.com/maps/api/staticmap?zoom=" .. zoom .. "&size=600x300&maptype=hybrid&center=" .. lat .. "," .. lon .. "&markers=color:blue%7Clabel:X%7C" .. lat .. "," .. lon
			table.insert(urls, url)
		end
		send_photos_from_url(receiver, urls)
	elseif matches[1] == "link" then
		return "Your Target Location On Google Map:\nhttps://www.google.com/maps/place/" .. lat .. "," .. lon
	end  
end

return {
	description = "Generate Map for GPS Coordinates", 
	usage = {
  "/gps loc [موقعیت]",
  "دریافت موقعیت مورد نظر",
  "/gps view [موقعیت]",
  "دریافت عکس واقعی موقعیت مورد نظر",
  "/gps map [موقعیت]",
  "دریافت نقشه موقعیت مورد نظر",
  "/gps link [موقعیت]",
  "دریافت لینک موقعیت مورد نظر",
	},
	patterns = {
		"^[!#/]gps (loc) ([^,]*)[,%s]([^,]*)$",
		"^[!#/]gps (map) ([^,]*)[,%s]([^,]*)$",
		"^[!#/]gps (view) ([^,]*)[,%s]([^,]*)$",
		"^[!#/]gps (link) ([^,]*)[,%s]([^,]*)$",
	}, 
	run = run 
}
end