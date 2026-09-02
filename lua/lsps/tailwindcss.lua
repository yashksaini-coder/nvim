-- classFunctions replaced the old experimental.classRegex patterns in
-- tailwindcss-language-server 0.14: entries are regexes matched against the
-- called function's name, so class strings inside cva()/cx()/cn() get
-- completion and linting without hand-written PCRE.
return {
	settings = {
		tailwindCSS = {
			classFunctions = { "cva", "cx", "cn", "clsx" },
		},
	},
}
