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
        { src = "https://github.com/slugbyte/lackluster.nvim" },
        { src = "https://github.com/nvim-mini/mini.nvim" },
        { src = "https://github.com/saghen/blink.cmp",        version = 'v1.8.0' },
        { src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/akinsho/toggleterm.nvim" },
        { src = "https://github.com/stevearc/oil.nvim" },
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

require("mini.pick").setup()
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

local function map(m, k, v)
        vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

vim.cmd.colorscheme("lackluster")

-- Keymaps
map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>pc", pack_clean)
map("n", "<leader>pu", vim.pack.update)
map("n", "<leader>e", ":Oil<cr>")

map("n", "<leader>r", ":so $MYVIMRC<cr>")
map("n", "<leader>,", ":tabnew $MYVIMRC<cr>")
map("n", "S", ":%s//g<Left><Left>")

map("n", "<leader>f", ":Pick files<cr>")
map("n", "<leader>h", ":Pick help<cr>")
map("n", "<leader>g", ":Pick grep_live<cr>")
map("n", "<leader>b", ":Pick grep_buffers<cr>")

map("v", "J", ":m'>+<CR>gv=gv")
map("v", "K", ":m-2<CR>gv=gv")
