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

		set({ "n", "v" }, "<M-s>", ":Gitsigns stage_hunk<cr>")
		set("n", "<M-u>", gs.undo_stage_hunk)
		set({ "n", "v" }, "<M-r>", ":Gitsigns reset_hunk<cr>")
		set("n", "<M-a>", gs.stage_buffer)
		set("n", "<M-b>", gs.reset_buffer)
		set("n", "<leader>p", gs.preview_hunk)
		set("n", "<leader>z", function()
			gs.blame_line({ full = false })
		end)
		set("n", "<leader><leader>z", function()
			gs.blame_line({ full = true })
		end)

		set({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>")
	end,
})
