local function run(msg, matches)
    local link = 'Xnxx\nhttp://www.xnxx.com/?k='..URL.escape(matches[1])
    local link = link..'\n➖➖➖➖➖➖➖➖➖➖➖➖\nBeeg\nhttp://beeg.com/search?q='..URL.escape(matches[1])
    local link = link..'\n➖➖➖➖➖➖➖➖➖➖➖➖\nPornHub\nhttp://www.pornhub.com/video/search?search='..URL.escape(matches[1])
    local link = link..'\n➖➖➖➖➖➖➖➖➖➖➖➖\nRedTube\nhttp://www.redtube.com/?search='..URL.escape(matches[1])
    local link = link..'\n➖➖➖➖➖➖➖➖➖➖➖➖\nYouPorn\nhttp://www.youporn.com/search/?query='..URL.escape(matches[1])
    local link = link..'\n➖➖➖➖➖➖➖➖➖➖➖➖\nTnaflix\nhttps://www.tnaflix.com/search.php?what='..URL.escape(matches[1])
    local link = link..'\n➖➖➖➖➖➖➖➖➖➖➖➖\nDirtyPornVids\nhttp://www.dirtypornvids.com/search-'..URL.escape(matches[1])..'/1.html'
    return link
end
return {
    patterns = {
        "^[/!#]porn (.*)"
    },
run = run
}