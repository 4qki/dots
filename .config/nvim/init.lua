-- minimal, complete neovim config by max (aqki), in only one file

-- install plugins
vim.pack.add({
    { src = 'https://github.com/miikanissi/modus-themes.nvim' },
    { src = 'https://github.com/marko-cerovac/material.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/slugbyte/lackluster.nvim' },
    { src = 'https://github.com/vague-theme/vague.nvim' },
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/ibhagwan/fzf-lua' },
    { src = 'https://github.com/norcalli/nvim-colorizer.lua' },
    { src = 'https://github.com/rose-pine/neovim' },
})

-- options
vim.opt.clipboard = 'unnamedplus' -- system clipboard
vim.opt.completeopt = {'menuone', 'noselect', 'popup'}
vim.cmd("set noswapfile")           -- do not use swapfile
vim.opt.undofile = true             -- use undofile
vim.opt.winborder = "rounded"       -- set window border
vim.opt.tabstop = 4                 -- number of visual spaces per TAB
vim.opt.softtabstop = 4             -- number of spaces in tab when editing
vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of Python
vim.opt.number = true               -- show absolute number
vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right

-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- theming
vim.opt.termguicolors = true        -- enable 24-bit RGB color in the TUI
require('colorizer').setup()
vim.cmd.colorscheme('lackluster')

local highlight_groups = {
    "Normal",
    "NormalNC",
    "LineNr",
    "Folded",
    "NonText",
    "SpecialKey",
    "VertSplit",
    "SignColumn",
    "EndOfBuffer",
}

for _, group in ipairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

-- statusline
vim.opt.showmode = false            -- hide hints

-- search
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = false            -- do not highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered
vim.opt.syntax = "on"               -- enable syntax highlighting

-- line wrap
vim.opt.wrap = false                 -- enable wraparound
vim.opt.linebreak = true            -- enable linebreaks
-- vim.opt.showbreak = "󱞩 "            -- show where line is broken
vim.opt.showbreak = "> "            -- show where line is broken
vim.cmd.filetype("plugin indent on")                -- allows nerdcommenter to work

-- keybindings
local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

map('n', '<leader>r', '<cmd>so $MYVIMRC<cr>')               -- reload config file
map('n', '<leader>,', '<cmd>tabnew $MYVIMRC<cr>')           -- open config file
map('n', 'S', ':%s//g<Left><Left>')                         -- replace all

-- fzf stuff
map('n', '<leader>p', '<cmd>FZF<cr>')
map('n', '<leader>c', '<cmd>FzfLua colorschemes<cr>')

-- plugin keybinds
map('n', '<leader>pu', '<cmd>lua vim.pack.update()<cr>')

-- move selected lines up and down
map('v', 'J', ":m'>+<CR>gv=gv")
map('v', 'K', ':m-2<CR>gv=gv')

map('n', '<leader>f', '<cmd>Ex<cr>')            -- open netrw

-- setup LSP
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.lsp.enable({
	"lua_ls", "cssls", "svelte", "tinymist",
	"rust_analyzer", "clangd", "ruff",
	"glsl_analyzer", "haskell-language-server", "hlint",
	"intelephense", "tailwindcss", "ts_ls", "html",
	"emmet_language_server", "emmet_ls", "solargraph", "zls"
})

