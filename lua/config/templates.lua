-- Starter files for C and C++, available two ways:
--
--   <leader>ic / <leader>iC   drop the template into the current buffer
--   `cp` + completion         expand it as a snippet (see plugins/cmp.lua)
--
-- The text lives here once so the keymap and the snippet cannot drift apart.

local M = {}

-- clangd is configured with --header-insertion=never precisely because this
-- file starts from <bits/stdc++.h> (see lua/lsps/clangd.lua).
M.cpp = {
	"#include <bits/stdc++.h>",
	"using namespace std;",
	"",
	"int main() {",
	"\tios::sync_with_stdio(false);",
	"\tcin.tie(nullptr);",
	"",
	"\t",
	"",
	"\treturn 0;",
	"}",
}

M.c = {
	"#include <stdio.h>",
	"#include <stdlib.h>",
	"",
	"int main(void) {",
	"\t",
	"",
	"\treturn 0;",
	"}",
}

--- Line (1-based) the cursor should land on: the blank indented line in main.
local CURSOR = { cpp = 8, c = 5 }

--- Replace the buffer with a template, or insert at the cursor if it has content.
---@param lang "c"|"cpp"
function M.insert(lang)
	local lines = M[lang]
	if not lines then
		return vim.notify("No template for " .. lang, vim.log.levels.WARN)
	end

	local buf = vim.api.nvim_get_current_buf()
	local cur = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local blank = #cur == 1 and cur[1] == ""

	if blank then
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.api.nvim_win_set_cursor(0, { CURSOR[lang], #lines[CURSOR[lang]] })
	else
		-- Don't clobber work in progress: put it after the cursor instead.
		local row = vim.api.nvim_win_get_cursor(0)[1]
		vim.api.nvim_buf_set_lines(buf, row, row, false, lines)
		vim.api.nvim_win_set_cursor(0, { row + CURSOR[lang], #lines[CURSOR[lang]] })
	end
	vim.cmd("startinsert!")
end

vim.keymap.set("n", "<leader>ic", function()
	M.insert("c")
end, { desc = "Insert C template" })

vim.keymap.set("n", "<leader>iC", function()
	M.insert("cpp")
end, { desc = "Insert C++ template" })

return M
