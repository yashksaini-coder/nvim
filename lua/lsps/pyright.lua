return {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
				},
			},
		},
	},
}
