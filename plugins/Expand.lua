local function run(msg, patterns)
   local response_body = {}
   local request_constructor = {
      url = patterns[1],
      method = "HEAD",
      sink = ltn12.sink.table(response_body),
      headers = {},
      redirect = false
   }

   local ok, response_code, response_headers, response_status_line = http.request(request_constructor)
   if ok and response_headers.location then
      return "Orginal Link: \n".. response_headers.location
   else
      return "Can't expand the url."
   end
end

return {
   description = "Expand a shortened URL to the original one.",
usage = {
  "نمایش لینک اورجینال لینک های کوتاه شده",
		  "دستور:",
          "/expand [لینک کوتاه شده]",
	},   patterns = {
      "^[#/!]expand (https?://[%w-_%.%?%.:/%+=&]+)$"
   },
   run = run
}