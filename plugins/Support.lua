do

function run(msg, matches)
  return "Need Help? \n\nIf You Ask A Questions About Bot Please Send A Message To:\n@iSepehr2001\n\nOr If You Reported Send A Message To: \n@iSepehr2001Bot"
  end
return {
  description = "shows support link", 
usage = {
  "در صورت وجود مشکل می توانید از این دستور استفاده کنید",
		  "دستور:",
          "/support",
	},  patterns = {
    "^([!/#]support)$",
  },
  run = run
}
end