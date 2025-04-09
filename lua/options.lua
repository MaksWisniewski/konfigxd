vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

vim.g.default_colorscheme = "gruvbox"

vim.opt.undodir = vim.fn.expand('$HOME/.vim/undodir')
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.laststatus = 2

vim.opt.background = 'dark'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.cino = 'p2s,(1,:1,g1,h2' -- indents
vim.opt.showmode = false         -- don't show "--insert--"

vim.g.python_recommended_style = false
vim.g.python_indent = {
    open_paren = 'shiftwidth()',
    nested_paren = 'shiftwidth()',
    continue = 'shiftwidth()'
}

-- color column
vim.opt.cc = "80"
vim.opt.signcolumn = "yes"

-- autocompletion based only on current buffer
vim.opt.complete = '.'

vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '>-', trail = '$' }

vim.opt.termguicolors = true

vim.opt.mouse = 'n'

vim.opt.updatetime = 50

-- vim.diagnostic.config({
--     severity_sort = true,
--     float = {
--         source = true,
--         style = "minimal",
--         header = "",
--         prefix = "",
--     },
--     signs = {
--         text = {
--             [vim.diagnostic.severity.WARN] = '●',
--             [vim.diagnostic.severity.ERROR] = '●',
--             [vim.diagnostic.severity.INFO] = '●',
--         },
--     },
--     virtual_text = {
--         virt_text_pos = 'eol',
--         format = function(diagnostic)
--             local mes = diagnostic.message
--             if diagnostic.source == 'pylint' then
--                 local colon = string.find(mes, ':') or 0
--                 return string.sub(mes, colon + 1)
--             elseif diagnostic.source == 'pyflakes' then
--                 local colon = string.find(mes, ':') or 0
--                 return string.sub(mes, colon + 1)
--             elseif diagnostic.source == 'pycodestyle' then
--                 local colon = string.find(mes, ':') or 0
--                 return string.sub(mes, colon + 1 + 4)
--             elseif diagnostic.source == 'formatdiff' then
--                 return "formatdiff"
--             end
--             return mes
--         end,
--     }
-- })

-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo.foldlevel = 999
-- vim.wo.foldnestmax = 1

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.spelllang = "en_gb"

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--     pattern = { "*.tex", "*.md" },
--     callback = function(ev)
--         vim.cmd([[hi SpellBad gui=undercurl guisp=red]])
--         vim.wo.foldmethod = 'marker'
--         vim.opt_local.spell = true
--         vim.opt_local.number = false
--         vim.opt_local.relativenumber = false
--     end
-- })
