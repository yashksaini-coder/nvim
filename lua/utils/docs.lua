local M = {}

M.url = "https://yashksaini-coder.github.io/nvim/"

function M.open(url)
	url = url or M.url
	local opener
	if vim.fn.has("mac") == 1 then
		opener = "open"
	elseif vim.fn.has("unix") == 1 then
		opener = "xdg-open"
	elseif vim.fn.has("win32") == 1 then
		opener = "start"
	else
		vim.notify("Unsupported platform for opening URLs", vim.log.levels.WARN)
		return
	end
	vim.fn.jobstart({ opener, url }, { detach = true })
	vim.notify("Opened " .. url, vim.log.levels.INFO)
end

return M
