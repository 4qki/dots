-- Opts
vim.g.mapleader = " "

vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.winborder = "rounded"
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false

-- Define LSP servers
local servers = { "lua_ls", "cssls", "rust_analyzer", "clangd", "html" }

-- Plugins
vim.pack.add({
        "https://github.com/slugbyte/lackluster.nvim",
        "https://github.com/nvim-mini/mini.nvim",
        "https://github.com/saghen/blink.cmp",
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/neovim/nvim-lspconfig",
        "https://github.com/nvim-telescope/telescope.nvim",
        "https://github.com/akinsho/toggleterm.nvim",
        "https://github.com/stevearc/oil.nvim",
        "https://github.com/lewis6991/gitsigns.nvim",
})

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

-- Funcs
local function pack_clean()
        local active_plugins = {}
        local unused_plugins = {}

        for _, plugin in ipairs(vim.pack.get()) do
                active_plugins[plugin.spec.name] = plugin.active
        end

        for _, plugin in ipairs(vim.pack.get()) do
                if not active_plugins[plugin.spec.name] then
                        table.insert(unused_plugins, plugin.spec.name)
                end
        end

        if #unused_plugins == 0 then
                print("No unused plugins.")
                return
        end

        local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
        if choice == 1 then
                vim.pack.del(unused_plugins)
        end
end

-- LSP and autocompletion
require("blink.cmp").setup({
        fuzzy = { implementation = "prefer_rust" }
})

for _, server in ipairs(servers) do
        vim.lsp.enable(server)
end

vim.cmd.colorscheme("lackluster")

-- Keymaps
local map = vim.keymap.set
local builtin = require("telescope.builtin")

map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>pc", pack_clean)
map("n", "<leader>pu", vim.pack.update)
map("n", "<leader>e", ":Oil<cr>")

map("n", "<leader>r", ":so $MYVIMRC<cr>")
map("n", "<leader>,", ":tabnew $MYVIMRC<cr>")
map("n", "S", ":%s//g<Left><Left>")

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>ft", builtin.colorscheme, { desc = "Telescope colorscheme" })

map("v", "J", ":m'>+<CR>gv=gv")
map("v", "K", ":m-2<CR>gv=gv")
