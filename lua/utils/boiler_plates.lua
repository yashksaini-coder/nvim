-- Full-buffer boilerplates only. Template files live in utils/boilerplates/.
local boilerplates_dir = vim.fn.stdpath("config") .. "/lua/utils/boilerplates"

local function read_file(path, fallback)
	local f = io.open(path, "r")
	local content = fallback or ""
	if f then
		content = f:read("*a")
		f:close()
	end
	return content
end

local function load_full_buffer(key, desc, filename, fallback)
	local path = boilerplates_dir .. "/" .. filename
	local content = read_file(path, fallback)
	vim.keymap.set("n", key, function()
		vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
	end, { desc = desc })
end

load_full_buffer("<leader>blp", "Boilerplate: C++ (CP)", "cpp_boilerplate.cpp", "// cpp")
load_full_buffer("<leader>blc", "Boilerplate: C (CP)", "c_boilerplate.c", "// c")
load_full_buffer("<leader>got", "Boilerplate: Go (CP)", "go_boilerplate.go", "// go")
load_full_buffer("<leader>rst", "Boilerplate: Rust (CP)", "rust_boilerplate.rs", "// rust")
load_full_buffer("<leader>plc", "Boilerplate: LeetCode C++", "leetcode_boilerplate.cpp", "// leetcode")
load_full_buffer("<leader>cse", "Boilerplate: CSES C++", "cses_boilerplate.cpp", "// cses")
