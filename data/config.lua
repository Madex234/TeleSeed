do local _ = {
  enabled_plugins = {
    "Add_Plugin",
    "Admin",
    "All",
    "Anti_Spam",
    "Aparat",
    "Arabic_Lock",
    "Arz",
    "Azan",
    "Banhammer",
    "Banner",
    "Broadcast",
    "Calculator",
    "ClashofClans",
    "Connect_Server",
    "CPU",
    "Dogify",
    "English_Lock",
    "Expand",
    "Face",
    "Fall",
    "Fantasy_Writer",
    "Feedback",
    "Filemanager",
    "Filterlist",
    "Get",
    "Get_Plugin",
    "Get_File",
    "Get_Welcome",
    "Gituser",
    "Google",
    "GPS",
    "Full_Help",
    "Help",
    "Image_Maker",
    "Info",
    "Ingroup",
    "Inpm",
    "Inrealm",
    "Instagram",
    "Invite",
    "IP",
    "Leave_Ban",
    "Linkpv",
    "Make_File",
    "Msg_Checks",
    "Music",
    "Onservice",
    "Owners",
    "Plugins",
    "Poker_Lock",
    "Qrcode",
    "Remove_Msg",
    "Search_Porn",
    "Server",
    "Set",
    "Set_Welcome",
    "Github",
    "Short_Link",
    "Spammer",
    "SpeedTest",
    "SpeedTest_Share",
    "SpeedTest_Simple",
    "Stats",
    "Sticker_Maker",
    "SuperGroup",
    "Support",
    "Tag_Lock",
    "Test_Robot",
    "Text_To_Image",
    "Text_To_Sticker",
    "Text_To_Voice",
    "Text_To_Voice_Fa",
    "Time",
    "Translate",
    "Version",
    "Weather",
    "White_List"
  },
  help_text_realm = "Realm Commands:\n\n!creategroup [Name]\nCreate a group\n\n!createrealm [Name]\nCreate a realm\n\n!setname [Name]\nSet realm name\n\n!setabout [group|sgroup] [GroupID] [Text]\nSet a group's about text\n\n!setrules [GroupID] [Text]\nSet a group's rules\n\n!lock [GroupID] [setting]\nLock a group's setting\n\n!unlock [GroupID] [setting]\nUnock a group's setting\n\n!settings [group|sgroup] [GroupID]\nSet settings for GroupID\n\n!wholist\nGet a list of members in group/realm\n\n!who\nGet a file of members in group/realm\n\n!type\nGet group type\n\n!kill chat [GroupID]\nKick all memebers and delete group\n\n!kill realm [RealmID]\nKick all members and delete realm\n\n!addadmin [id|username]\nPromote an admin by id OR username *Sudo only\n\n!removeadmin [id|username]\nDemote an admin by id OR username *Sudo only\n\n!list groups\nGet a list of all groups\n\n!list realms\nGet a list of all realms\n\n!support\nPromote user to support\n\n!-support\nDemote user from support\n\n!log\nGet a logfile of current group or realm\n\n!broadcast [text]\n!broadcast Hello !\nSend text to all groups\nOnly sudo users can run this command\n\n!bc [group_id] [text]\n!bc 123456789 Hello !\nThis command will send text to [group_id]\n\n\n**You can use \"#\", \"!\", or \"/\" to begin all commands\n\n\n*Only admins and sudo can add bots in group\n\n\n*Only admins and sudo can use kick,ban,unban,newlink,setphoto,setname,lock,unlock,set rules,set about and settings commands\n\n*Only admins and sudo can use res, setowner, commands\n",
  help_text_super = "Wrong Commands! Please Use This Command For Full Help /help>\n",
  moderation = {
    data = "data/moderation.json"
  },
  sudo_users = {
    69759863,
    48167877,
    0
  }
}
return _
end
