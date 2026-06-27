-- Pure novelty: cellular-automaton "destroys" the current buffer with an
-- animation. `make_it_rain` and `game_of_life` are the two built-in effects.
return {
	"Eandrju/cellular-automaton.nvim",
	cmd = "CellularAutomaton",
	keys = {
		{ "<leader>ar", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Animation: make it rain" },
		{ "<leader>ag", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Animation: game of life" },
	},
}
