vim.pack.add({
	"https://github.com/slugbyte/lackluster.nvim",
	"https://github.com/nexxeln/vesper.nvim",
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("vague").setup({
	transparent = "true",
})

require("lackluster").setup({
	tweak_background = {
		normal = "none",
	},
})

local servers = {
	clangd = {},
	rust_analyzer = {},
	gopls = {},
	zls = {},
	ols = {},
	ts_ls = {},
	stylua = {},
	pyright = {},
	lua_ls = {},
}

local ensure_installed = vim.tbl_keys(servers or {})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
require("fidget").setup()

require("gitsigns").setup({
	signs = {
		add = { text = "+" }, ---@diagnostic disable-line: missing-fields
		change = { text = "~" }, ---@diagnostic disable-line: missing-fields
		delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
	},
	current_line_blame = true,
})

require("oil").setup({
	columns = { "icon" },
	view_options = {
		show_hidden = true,
	},
})

require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

require("blink.cmp").setup({
	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
	},
	fuzzy = {
		implementation = "prefer_rust",
	},
	signature = {
		enabled = true,
	},
	keymap = {
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets" },
	},
})

require("telescope").setup({
	defaults = {
		preview = { treesitter = true },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"", -- top
			"", -- right
			"", -- bottom
			"", -- left
			"", -- top-left
			"", -- top-right
			"", -- bottom-right
			"", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
})
require("telescope").load_extension("ui-select")

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
