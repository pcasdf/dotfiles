require("gitsigns").setup({
	preview_config = { border = "single" },
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function set(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		set("n", "]h", function()
			if vim.wo.diff then
				return "]h"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		set("n", "[h", function()
			if vim.wo.diff then
				return "[h"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		set({ "n", "v" }, "<leader><leader>s", ":Gitsigns stage_hunk<CR>")
		set("n", "<leader><leader>u", gs.undo_stage_hunk)
		set({ "n", "v" }, "<leader><leader>r", ":Gitsigns reset_hunk<CR>")
		set("n", "<leader><leader>S", gs.stage_buffer)
		set("n", "<leader><leader>R", gs.reset_buffer)
		set("n", "<leader>p", gs.preview_hunk)
		set("n", "<leader>z", function()
			gs.blame_line({ full = false })
		end)
		set("n", "<leader>Z", function()
			gs.blame_line({ full = true })
		end)

		set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
