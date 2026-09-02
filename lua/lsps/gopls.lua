return {
	settings = {
		gopls = {
			staticcheck = true, -- the full staticcheck suite, not gopls' subset
			-- Only affects gopls' own formatting and code actions — conform still
			-- runs plain gofmt on save (see plugins/conform.lua).
			gofumpt = true,
			-- No `analyses` block: unusedparams is already on by default, and shadow
			-- is off upstream on purpose ("a high rate of false positives" — it fires
			-- on idiomatic `if err := f(); err != nil`). Enable it per-project if wanted.
		},
	},
}
