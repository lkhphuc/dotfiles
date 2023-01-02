local M = {
	"kevinhwang91/nvim-hlslens", -- show number beside search highlight
}

function M.config()
	local hlslens = require("hlslens")
	hlslens.setup({ calm_down = true })
	-- vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
	-- vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
	vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]])
	vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]])
	vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]])
	vim.keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]])
	-- run `:nohlsearch` and export results to quickfix
	vim.keymap.set({ "n", "x" }, "<leader>L", function()
		vim.schedule(function()
			if require("hlslens").exportLastSearchToQuickfix() then
				vim.cmd("cw")
			end
		end)
		return ":noh<CR>"
	end, { expr = true })

	-- if Neovim is 0.8.0 before, remap yourself.
	local function nN(char)
		local ok, winid = hlslens.nNPeekWithUFO(char)
		if ok and winid then
			-- Safe to override buffer scope keymaps remapped by ufo,
			-- ufo will restore previous buffer keymaps before closing preview window
			-- Type <CR> will switch to preview window and fire `tarce` action
			vim.keymap.set("n", "<CR>", function()
				local keyCodes = vim.api.nvim_replace_termcodes("<Tab><CR>", true, false, true)
				vim.api.nvim_feedkeys(keyCodes, "im", false)
			end, { buffer = true })
		end
	end

	vim.keymap.set({ "n", "x" }, "n", function() nN("n") end)
	vim.keymap.set({ "n", "x" }, "N", function() nN("N") end)
end

return M
