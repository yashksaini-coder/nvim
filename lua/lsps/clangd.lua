-- clangd takes almost all of its configuration on the command line, not
-- through `settings` — the rest lives in .clangd files.
return {
	cmd = {
		"clangd",
		"--background-index", -- index on a worker thread, persisted to .cache/clangd
		"--clang-tidy", -- clang-tidy checks as inline diagnostics
		-- Competitive programming means <bits/stdc++.h>. iwyu insertion would
		-- keep proposing the individual headers that already covers.
		"--header-insertion=never",
		"--completion-style=detailed", -- one entry per overload, with its signature
		"--fallback-style=llvm", -- formatting when no .clang-format is found
		-- Let clangd run gcc/g++ to learn their system include paths, so a
		-- compile_commands.json built with g++ resolves libstdc++ headers.
		"--query-driver=/usr/bin/g++,/usr/bin/gcc,/usr/bin/clang++,/usr/bin/clang",
	},
}
