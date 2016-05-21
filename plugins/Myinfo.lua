local function callback_reply(extra, success, result)
	--icon & rank ------------------------------------------------------------------------------------------------
	userrank = "Member"
	if tonumber(result.from.id) == 48167877 then
		userrank = "Master ⭐⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Master.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo ⭐⭐⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Sudo.webp", ok_cb, false)
	elseif is_admin1(result.from.id) then
		userrank = "Admin ⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Admin.webp", ok_cb, false)
	elseif is_owner2(result.from.id, result.to.id) then
		userrank = "Owner ⭐⭐"
		send_document(org_channel_id,"data/sticker/Leader.webp", ok_cb, false)
	elseif is_momod2(result.from.id, result.to.id) then
		userrank = "Moderator ⭐"
		send_document(org_channel_id,"data/sticker/Moderator.webp", ok_cb, false)
	elseif tonumber(result.from.id) == tonumber(our_id) then
		userrank = "TeleGuard ⭐⭐⭐⭐⭐⭐"
		send_document(org_channel_id,"umbrella/stickers/umb.webp", ok_cb, false)
	elseif result.from.username then
		if string.sub(result.from.username:lower(), -3) == "bot" then
			userrank = "API Bot"
			send_document(org_channel_id,"umbrella/stickers/api.webp", ok_cb, false)
		end
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.from.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = ""
	end
	--cont ------------------------------------------------------------------------------------------------
	local user_info = {}
	local uhash = 'user:'..result.from.id
	local user = redis:hgetall(uhash)
	local um_hash = 'msgs:'..result.from.id..':'..result.to.id
	user_info.msgs = tonumber(redis:get(um_hash) or 0)
	--msg type ------------------------------------------------------------------------------------------------
	if result.media then
		if result.media.type == "document" then
			if result.media.text then
				msg_type = "Sticker"
			else
				msg_type = "Other"
			end
		elseif result.media.type == "photo" then
			msg_type = "Image"
		elseif result.media.type == "video" then
			msg_type = "Video"
		elseif result.media.type == "audio" then
			msg_type = "Voice"
		elseif result.media.type == "geo" then
			msg_type = "Location"
		elseif result.media.type == "contact" then
			msg_type = "Phonenumber"
		elseif result.media.type == "file" then
			msg_type = "File"
		elseif result.media.type == "webpage" then
			msg_type = "Preview Site"
		elseif result.media.type == "unsupported" then
			msg_type = "Gif"
		else
			msg_type = "Unknown"
		end
	elseif result.text then
		if string.match(result.text, '^%d+$') then
			msg_type = "Number"
		elseif string.match(result.text, '%d+') then
			msg_type = "Number And Letters"
		elseif string.match(result.text, '^@') then
			msg_type = "Username"
		elseif string.match(result.text, '@') then
			msg_type = "Including Username"
		elseif string.match(result.text, '[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]') then
			msg_type = "Telegram Link"
		elseif string.match(result.text, '[Hh][Tt][Tt][Pp]') then
			msg_type = "Site Link"
		elseif string.match(result.text, '[Ww][Ww][Ww]') then
			msg_type = "Site Link"
		elseif string.match(result.text, '?') then
			msg_type = "Question"
		else
			msg_type = "Text"
		end
	end
	--hardware ------------------------------------------------------------------------------------------------
	if result.text then
		inputtext = string.sub(result.text, 0,1)
		if result.text then
			if string.match(inputtext, "[a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z]") then
				hardware = "Computer"
			elseif string.match(inputtext, "[A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z]") then
				hardware = "Mobile"
			else
				hardware = ""
			end
		else
			hardware = ""
		end
	else
		hardware = ""
	end
	--phone ------------------------------------------------------------------------------------------------
	if access == 1 then
		if result.from.phone then
			number = "0"..string.sub(result.from.phone, 3)
			if string.sub(result.from.phone, 0,2) == '98' then
				number = number.."\n#Location: Iran Islamic"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\n#Simcard: Hamrahaval"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\n#Simcard: Taliya"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\n#Simcard: Rightel"
				else
					number = number.."\n#Simcard: Other"
				end
			else
				number = number.."\n#Location: Other\n#Simcard: Other"
			end
		else
			number = ""
		end
	elseif access == 0 then
		if result.from.phone then
			number = "You Don't Have Access"
			if string.sub(result.from.phone, 0,2) == '98' then
				number = number.."\n#Location: Iran Islamic"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\n#Simcard: Hamrahaval"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\n#Simcard: Taliya"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\n#Simcard: Rightel"
				else
					number = number.."\n#Simcard: Other"
				end
			else
				number = number.."\n#Location: Other\n#Simcard: Other"
			end
		else
			number = ""
		end
	end
	--info ------------------------------------------------------------------------------------------------
	info = "#Fullname: "..string.gsub(result.from.print_name, "_", " ").."\n"
	.."#Firstname: "..(result.from.first_name or "").."\n"
	.."#Lastname: "..(result.from.last_name or "").."\n\n"
	.."#Phonenumber: "..number.."\n\n"
	.."#Username: Telegram.me/"..(result.from.username or "").."\n"
	.."#ID: "..result.from.id.."\n"
	.."#Rank: "..usertype.."\n"
	.."#Position: "..userrank.."\n\n"
	.."#Interface: "..hardware.."\n"
	.."#Total Messages: "..user_info.msgs.."\n"
	.."#Type Of Message: "..msg_type.."\n\n"
	.."#SuperGroup Name: "..string.gsub(result.to.print_name, "_", " ").."\n"
	.."#SuperGroup ID: "..result.to.id
	send_large_msg(org_channel_id, info)
end

local function callback_res(extra, success, result)
	if success == 0 then
		return send_large_msg(org_channel_id, "Username Not Found")
	end
	--icon & rank ------------------------------------------------------------------------------------------------
		if tonumber(result.id) == 48167877 then
		userrank = "Master ⭐⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Master.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo ⭐⭐⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Sudo.webp", ok_cb, false)
	elseif is_admin1(result.id) then
		userrank = "Admin ⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Admin.webp", ok_cb, false)
	elseif is_owner2(result.id, extra.channel2) then
		userrank = "Owner ⭐⭐"
		send_document(org_channel_id,"data/sticker/Leader.webp", ok_cb, false)
	elseif is_momod2(result.id, extra.channel2) then
		userrank = "Moderator ⭐"
		send_document(org_channel_id,"data/sticker/Moderator.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(our_id) then
		userrank = "TeleGuard ⭐⭐⭐⭐⭐⭐"
		send_document(org_channel_id,"umbrella/stickers/umb.webp", ok_cb, false)
	elseif result.from.username then
		if string.sub(result.from.username:lower(), -3) == "bot" then
			userrank = "API Bot"
			send_document(org_channel_id,"umbrella/stickers/api.webp", ok_cb, false)
	else
		userrank = "Member"
	end
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = ""
	end
	--phone ------------------------------------------------------------------------------------------------
if access == 1 then
		if result.phone then
			number = "0"..string.sub(result.phone, 3)
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\n#Location: Iran Islamic"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\n#Simcard: Hamrahaval"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\n#Simcard: Taliya"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\n#Simcard: Rightel"
				else
					number = number.."\n#Simcard: Other"
				end
			else
				number = number.."\n#Location: Other\n#Simcard: Other"
			end
		else
			number = ""
		end
	elseif access == 0 then
		if result.phone then
			number = "You Don't Have Access"
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\n#Location: Iran Islamic"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\n#Simcard: Hamrahaval"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\n#Simcard: Taliya"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\n#Simcard: Rightel"
				else
					number = number.."\n#Simcard: Other"
				end
			else
				number = number.."\n#Location: Other\n#Simcard: Other"
			end
		else
			number = ""
		end
	end
	--info ------------------------------------------------------------------------------------------------
	info = "#Fullname: "..string.gsub(result.print_name, "_", " ").."\n"
	.."#Firstname: "..(result.first_name or "").."\n"
	.."#Lastname: "..(result.last_name or "").."\n\n"
	.."#Phonenumber: "..number.."\n\n"
	.."#Username: Telegram.me/"..(result.username or "").."\n"
	.."#ID: "..result.id.."\n"
	.."#Rank: "..usertype.."\n"
	.."#Position: "..userrank.."\n\n"
	send_large_msg(org_channel_id, info)
end

local function callback_info(extra, success, result)
	if success == 0 then
		return send_large_msg(org_channel_id, "Username Not Found")
	end
	--icon & rank ------------------------------------------------------------------------------------------------
	if tonumber(result.id) == 48167877 then
		userrank = "Master ⭐⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Master.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo ⭐⭐⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Sudo.webp", ok_cb, false)
	elseif is_admin1(result.id) then
		userrank = "Admin ⭐⭐⭐"
		send_document(org_channel_id,"data/sticker/Admin.webp", ok_cb, false)
	elseif is_owner2(result.id, extra.channel2) then
		userrank = "Owner ⭐⭐"
		send_document(org_channel_id,"data/sticker/Leader.webp", ok_cb, false)
	elseif is_momod2(result.id, extra.channel2) then
		userrank = "Moderator ⭐"
		send_document(org_channel_id,"data/sticker/Moderator.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(our_id) then
		userrank = "TeleGuard ⭐⭐⭐⭐⭐⭐"
		send_document(org_channel_id,"umbrella/stickers/umb.webp", ok_cb, false)
	elseif result.from.username then
		if string.sub(result.from.username:lower(), -3) == "bot" then
			userrank = "API Bot"
			send_document(org_channel_id,"umbrella/stickers/api.webp", ok_cb, false)
	else
		userrank = "Member"
	end
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = ""
	end
	--phone ------------------------------------------------------------------------------------------------
		if access == 1 then
		if result.phone then
			number = "0"..string.sub(result.phone, 3)
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\n#Location: Iran Islamic"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\n#Simcard: Hamrahaval"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\n#Simcard: Taliya"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\n#Simcard: Rightel"
				else
					number = number.."\n#Simcard: Other"
				end
			else
				number = number.."\n#Location: Other\n#Simcard: Other"
			end
		else
			number = ""
		end
	elseif access == 0 then
		if result.phone then
			number = "You Don't Have Access"
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\n#Location: Iran Islamic"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\n#Simcard: Hamrahaval"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\n#Simcard: Taliya"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\n#Simcard: MTN Irancell"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\n#Simcard: Rightel"
				else
					number = number.."\n#Simcard: Other"
				end
			else
				number = number.."\n#Location: Other\n#Simcard: Other"
			end
		else
			number = ""
		end
	end
	--name ------------------------------------------------------------------------------------------------
	if string.len(result.print_name) > 15 then
		fullname = string.sub(result.print_name, 0,15).."..."
	else
		fullname = result.print_name
	end
	if result.first_name then
		if string.len(result.first_name) > 15 then
			firstname = string.sub(result.first_name, 0,15).."..."
		else
			firstname = result.first_name
		end
	else
		firstname = ""
	end
	if result.last_name then
		if string.len(result.last_name) > 15 then
			lastname = string.sub(result.last_name, 0,15).."..."
		else
			lastname = result.last_name
		end
	else
		lastname = ""
	end
	--info ------------------------------------------------------------------------------------------------
	info = "#Fullname: "..string.gsub(result.print_name, "_", " ").."\n"
	.."#Firstname: "..(result.first_name or "").."\n"
	.."#Lastname: "..(result.last_name or "").."\n\n"
	.."#Phonenumber: "..number.."\n\n"
	.."#Username: Telegram.me/"..(result.username or "").."\n"
	.."#ID: "..result.id.."\n"
	.."#Rank: "..usertype.."\n"
	.."#Position: "..userrank.."\n\n"
	send_large_msg(org_channel_id, info)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
	org_channel_id = "channel#id"..msg.to.id
	if is_sudo(msg) then
		access = 1
	else
		access = 0
	end
	if matches[1] == 'infodel' and is_sudo(msg) then
		azlemagham = io.popen('rm ./info/'..matches[2]..'.txt'):read('*all')
		return 'Rank Was Removed'
	elseif matches[1] == 'setrank' and is_sudo(msg) then
		local name = string.sub(matches[2], 1, 50)
		local text = string.sub(matches[3], 1, 10000000000)
		local file = io.open("./info/"..name..".txt", "w")
		file:write(text)
		file:flush()
		file:close() 
		return "New Rank Seted"
	elseif #matches == 2 then
		local cbres_extra = {channelid = msg.to.id}
		if string.match(matches[2], '^%d+$') then
			return user_info('user#id'..matches[2], callback_info, cbres_extra)
		else
			return res_user(matches[2]:gsub("@",""), callback_res, cbres_extra)
		end
	else
		--custom rank ------------------------------------------------------------------------------------------------
		local file = io.open("./info/"..msg.from.id..".txt", "r")
		if file ~= nil then
			usertype = file:read("*all")
		else
			usertype = ""
		end
		--hardware ------------------------------------------------------------------------------------------------
		if matches[1] == "myinfo" then
			hardware = "Computer"
		else
			hardware = "Mobile"
		end
		if not msg.reply_id then
			--contor ------------------------------------------------------------------------------------------------
			local user_info = {}
			local uhash = 'user:'..msg.from.id
			local user = redis:hgetall(uhash)
			local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id
			user_info.msgs = tonumber(redis:get(um_hash) or 0)
			--icon & rank ------------------------------------------------------------------------------------------------
			if tonumber(msg.from.id) == 48167877 then
				userrank = "Master ⭐⭐⭐⭐"
				send_document(org_channel_id,"data/sticker/Master.webp", ok_cb, false)
			elseif is_sudo(msg) then
				userrank = "Sudo ⭐⭐⭐⭐⭐"
				send_document(org_channel_id,"data/sticker/Sudo.webp", ok_cb, false)
			elseif is_admin1(msg) then
				userrank = "Admin ⭐⭐⭐"
				send_document(org_channel_id,"data/sticker/Admin.webp", ok_cb, false)
			elseif is_owner(msg) then
				userrank = "Owner ⭐⭐"
				send_document(org_channel_id,"data/sticker/Leader.webp", ok_cb, false)
			elseif is_momod(msg) then
				userrank = "Moderator ⭐"
				send_document(org_channel_id,"data/sticker/Moderator.webp", ok_cb, false)
			else
				userrank = "Member"
			end
			--number ------------------------------------------------------------------------------------------------
			if msg.from.phone then
				numberorg = string.sub(msg.from.phone, 3)
				number = "0"..string.sub(numberorg, 0,6)
				if string.sub(msg.from.phone, 0,2) == '98' then
				number = number.."\n#Location: Iran Islamic"
					if string.sub(msg.from.phone, 0,4) == '9891' then
					number = number.."\n#Simcard: Hamrahaval"
					elseif string.sub(msg.from.phone, 0,5) == '98932' then
					number = number.."\n#Simcard: Taliya"
					elseif string.sub(msg.from.phone, 0,4) == '9893' then
					number = number.."\n#Simcard: MTN Irancell"
					elseif string.sub(msg.from.phone, 0,4) == '9890' then
					number = number.."\n#Simcard: MTN Irancell"
					elseif string.sub(msg.from.phone, 0,4) == '9892' then
					number = number.."\n#Simcard: Rightel"
					else
					number = number.."\n#Simcard: Other"
					end
				else
				number = number.."\n#Location: Other\n#Simcard: Other"
				end
			else
				number = ""
			end
			--info ------------------------------------------------------------------------------------------------
			local info = "#Fullname: "..string.gsub(msg.from.print_name, "_", " ").."\n"
					.."#Firstname: "..(msg.from.first_name or "").."\n"
					.."#Lastname: "..(msg.from.last_name or "").."\n\n"
					.."#Phonenumber: "..number.."\n\n"
					.."#Username: Telegram.me/"..(msg.from.username or "").."\n"
					.."#ID: "..msg.from.id.."\n"
					.."#Rank: "..usertype.."\n"
					.."#Position: "..userrank.."\n\n"
					.."#Interface: "..hardware.."\n"
					.."#Total Messages: "..user_info.msgs.."\n\n"
					.."#SuperGroup Name: "..string.gsub(msg.to.print_name, "_", " ").."\n"
					.."#SuperGroup ID: "..msg.to.id
			return info
		else
			get_message(msg.reply_id, callback_reply, false)
		end
	end
end

return {
	description = "User Infomation",
	usagehtm = '<tr><td align="center">info</td><td align="right">اطلاعات کاملی را راجبه شما، گروهی که در آن هستید و مقامتان میدهد همچنین با رپلی کردن میتوانید اطلاعات فرد مورد نظر را نیز ببینید</td></tr>'
	..'<tr><td align="center">/info مقام آیدی</td><td align="right">اعطای مقام به شخص به جر مقامهای اصلی</td></tr>'
	..'<tr><td align="center">/infodel آیدی</td><td align="right">حذف مقام اعطا شده</td></tr>',
	usage = {
		user = {
			"info: اطلاعات شما",
			"info (reply): اطلاعات دیگران",
			},
		sudo = {
			"/info (id) (txt) : اعطای مقام",
			"/infodel : حذف مقام",
			},
		},
	patterns = {
	    "^[#!/]([Ii]nfodel) (.*)$",
		"^[#!/]([Ss]etrank) ([^%s]+) (.*)$",
		"^([Ii]nfo) (.*)$",
		"^[!/#]myinfo",
		"^[!/#]Myinfo",
	},
	run = run,
}
