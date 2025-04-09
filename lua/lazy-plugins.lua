-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup the plugin manager
require("lazy").setup({
    defaults = { lazy = true },
    lockfile = vim.fn.stdpath("cache") .. "/lazy-lock.json",

    'nvim-lua/plenary.nvim', -- utilities used by other plugins

    -- Options for these plugins are located in .config/nvim/lua/plugins/
    require 'plugins.gruvbox',            -- colorscheme
    require 'plugins.lualine',            -- bottom status line
    require 'plugins.treesitter',         -- for better syntax highlighting etc.
    require 'plugins.treesitter-context', -- context line for long functions
    require 'plugins.telescope',          -- search utility
    require 'plugins.neo-tree',           -- tree to browse file system
    require 'plugins.lsp',                -- errors / linting of code
    require 'plugins.cmp',                -- autocompletion
    -- Plugins below are imported with little/no extra options

})
