-- tsserver has no `inlayHints.enabled` switch: every hint kind is its own
-- `include*` preference, and the whole set has to be repeated under
-- javascript.* or JS files get nothing. The old one-key version did nothing.
local hints = {
	includeInlayParameterNameHints = "all", -- "none" | "literals" | "all"
	includeInlayParameterNameHintsWhenArgumentMatchesName = false, -- foo(foo) is noise
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

return {
	settings = {
		typescript = { inlayHints = hints },
		javascript = { inlayHints = hints },
	},
}
