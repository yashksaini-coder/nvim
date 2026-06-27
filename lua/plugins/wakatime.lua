-- WakaTime: passive coding-time tracker.
-- API key + CLI live in ~/.wakatime.cfg / ~/.wakatime/ — set up once via :WakaTimeApiKey.
return {
	"wakatime/vim-wakatime",
	event = { "BufReadPost", "BufNewFile" },
}
