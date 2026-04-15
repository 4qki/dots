vim.pack.add({
        "https://github.com/slugbyte/lackluster.nvim",
        "https://github.com/vague-theme/vague.nvim",
        "https://github.com/nvim-mini/mini.nvim",
        "https://github.com/saghen/blink.cmp",
        "https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/mason-org/mason.nvim",
		"https://github.com/mason-org/mason-lspconfig.nvim",
		"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		"https://github.com/nvim-telescope/telescope.nvim",
        "https://github.com/akinsho/toggleterm.nvim",
        "https://github.com/stevearc/oil.nvim",
        "https://github.com/lewis6991/gitsigns.nvim",
})

require("vague").setup({
		transparent = 'true'
})

require("lackluster").setup({
	tweak_background = {
		normal = 'none'
	}
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
        columns = {
                "permissions",
                "icon"
        },
        view_options = {
                show_hidden = true
        }
})

require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
                border = "curved"
        }
})

require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

-- LSP and autocompletion
require("blink.cmp").setup({
        fuzzy = { implementation = "prefer_rust" }
})

for _, server in ipairs(servers) do
        vim.lsp.enable(server)
end
