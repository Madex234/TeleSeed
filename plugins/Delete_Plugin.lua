local function run(msg, matches)
    if matches[1] == "delplug" and is_sudo(msg) then
text = io.popen("cd plugins && rm "..matches[2]..".lua")
return text.."Plugin ["..matches[2].."] Was Removed"
end 
end

return { 
patterns = {
'^[#!/](delplug) (.*)$' 
},
run = run,
}
