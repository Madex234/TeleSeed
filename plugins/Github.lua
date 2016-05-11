local function run(msg, matches)
	if matches[1]:lower() == "github>" then
		local dat = https.request("https://api.github.com/repos/"..matches[2])
		local jdat = JSON.decode(dat)
		if jdat.message then
			return "Wrong Command, Write Like This:\nExp: !github RadicalTeam/TeleGuard"
		end
		local base = "curl 'https://codeload.github.com/"..matches[2].."/zip/master'"
		local data = io.popen(base):read('*all')
		f = io.open("/root/TeleSeed/data/file/github/Github.zip", "w+")
		f:write(data)
		f:close()
		return send_document("channel#id"..msg.to.id, "/root/TeleSeed/data/file/github/Github.zip", ok_cb, false)
	else
		local dat = https.request("https://api.github.com/repos/"..matches[2])
		local jdat = JSON.decode(dat)
		if jdat.message then
			return "Wrong Command, Write Like This:\nExp: !github RadicalTeam/TeleGuard"
		end
		local res = https.request(jdat.owner.url)
		local jres = JSON.decode(res)
		send_photo_from_url("channel#id"..msg.to.id, jdat.owner.avatar_url)
		return "Account Information:\n"
			.."Account Name: "..(jres.name or "").."\n"
			.."Username: "..jdat.owner.login.."\n"
			.."Company Name: "..(jres.company or "").."\n"
			.."Website: "..(jres.blog or "").."\n"
			.."Emeil: "..(jres.email or "").."\n"
			.."Location: "..(jres.location or "").."\n"
			.."Number Of Projects: "..jres.public_repos.."\n"
			.."Followers: "..jres.followers.."\n"
			.."Following: "..jres.following.."\n"
			.."Registration Creating An Account: "..jres.created_at.."\n"
			.."About Account: "..(jres.bio or "").."\n➖➖➖➖➖➖➖➖➖➖➖➖\n"
			.."Project Information:\n"
			.."Project Name: "..jdat.name.."\n"
			.."Github Page: "..jdat.html_url.."\n"
			.."Project Blog: "..(jdat.homepage or "").."\n"
			.."Registration Creating An Project: "..jdat.created_at.."\n"
			.."Last Update: "..(jdat.updated_at or "").."\n"
			.."Programming Language: "..(jdat.language or "-----").."\n"
			.."Stars: "..jdat.stargazers_count.."\n"
			.."Watchers: "..jdat.watchers_count.."\n"
			.."Forks: "..jdat.forks_count.."\n"
			.."Subscribers: "..jdat.subscribers_count.."\n"
			.."About Project:\n"..(jdat.description or "-----").."\n"
	end
end

return {
	description = "Github Informations",
	usage = {
		"github (account/proje) : مشخصات پروژه و اکانت",
		"github> (account/proje) : دانلود سورس",
		},
	patterns = {
		"^([!#/]github>) (.*)",
		"^([!#/]github) (.*)",
		},
	run = run
}