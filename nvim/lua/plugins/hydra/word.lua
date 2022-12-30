local M = { }

function M.setup()
	local Hydra = require("hydra") Hydra({
		name = "Quick words",
		config = {
			color = "pink",
      hint = {type="statusline"},
		},
		mode = { "n", "x", "o" },
		body = ",",
		heads = {
			{ "w", "<Plug>(smartword-w)" },
			{ "b", "<Plug>(smartword-b)" },
			{ "e", "<Plug>(smartword-e)" },
			{ "ge", "<Plug>(smartword-ge)" },
			{ "<Esc>", nil, { exit = true, mode = "n" } },
		},
	})
end

return M
