require("gitlinker").setup({
	opts = {
		remote = nil,
		add_current_line_on_normal_mode = true,
		action_callback = require("gitlinker.actions").copy_to_clipboard,
		print_url = true,
	},
	callbacks = {
		["github.com"] = require("gitlinker.hosts").get_github_type_url,
	},
	mappings = "<M-l>",
})

local set = vim.keymap.set
local options = { noremap = true, silent = true }

set("n", "<M-o>", function()
	require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
end, options)
set("v", "<M-o>", function()
	require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
end, options)
