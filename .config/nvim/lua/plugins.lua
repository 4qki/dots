vim.pack.add({
	{ src = "https://github.com/slugbyte/lackluster.nvim", },
	{ src = "https://github.com/nexxeln/vesper.nvim", },
	{ src = "https://github.com/dgox16/oldworld.nvim", },
	{ src = "https://github.com/nvim-mini/mini.nvim", },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-lua/plenary.nvim", },
	{ src = "https://github.com/mason-org/mason.nvim", },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim", },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" }
})

require("lackluster").setup({
	tweak_background = { normal = "none" },
})

require("vesper").setup({
	transparent = "true",
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
require("mini.notify").setup()

require("toggleterm").setup(
	{
		open_mapping = [[<c-\>]],
		direction = 'float',
		float_opts = {
			border = 'curved',
		}
	}
)

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

local telescope = require("telescope")
telescope.setup({
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
telescope.load_extension("ui-select")

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
