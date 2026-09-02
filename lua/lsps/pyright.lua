-- ruff runs alongside as a language server (see the gate map in plugins/lsp.lua)
-- and owns lints, import sorting and formatting. pyright is here for types only,
-- so its organize-imports action is turned off to avoid two sources fighting.
return {
	settings = {
		pyright = { disableOrganizeImports = true },
		python = {
			analysis = {
				-- "standard" (the default) and "strict" bury unannotated scripts in
				-- errors. Raise it per-project in pyrightconfig.json instead.
				typeCheckingMode = "basic",
			},
		},
	},
}
