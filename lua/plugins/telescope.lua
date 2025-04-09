return { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    lazy = true,
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-bibtex.nvim',
        'benfowler/telescope-luasnip.nvim',
    },
    init = function()
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
        vim.keymap.set('n', '<leader>sF', function()
            builtin.find_files(require "telescope.themes".get_cursor({
                cwd = "~",
                layout_config = { width = 0.9, preview_width = 0.4, },
                find_command = { "fdfind", "-t=f", "-a" },
                path_display = { "absolute" },
            }))
        end, { desc = 'Search Files' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current Word' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume Previous Search' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
        vim.keymap.set('n', '<leader>sb',
            '<cmd> lua require("telescope").extensions.bibtex.bibtex(require("telescope.themes").get_dropdown{ previewer = false })<CR>',
            { desc = 'Search Bibtex' })

        vim.keymap.set('n', '<leader>/',
            function()
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false, })
            end,
            { desc = 'Fuzzily search in current buffer' }
        )

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn',
            function()
                builtin.find_files {
                    cwd = vim.fn.stdpath 'config',
                    hidden = false,
                }
            end,
            { desc = 'Search Neovim files' }
        )
    end,
    config = function()
        local entry_append = function(prompt_bufnr)
            local entry = require('telescope.actions.state').get_selected_entry()[1]
            require('telescope.actions').close(prompt_bufnr)
            vim.api.nvim_put({ entry }, 'c', false, true)
        end
        require('telescope').setup {
            defaults = {
                layout_config = {
                    vertical = { width = 0.5, }
                },
                mappings = {
                    i = {
                        ["<esc>"] = 'close',
                        ["<C-i>"] = entry_append,
                    },
                },
                file_ignore_patterns = {
                    "/tmp/nvim.dkuczynski/",
                },
            },
            pickers = {
                find_files = { disable_devicons = true },
                grep_string = {
                    theme = "dropdown",
                    disable_devicons = true,
                },
                live_grep = {
                    theme = "dropdown",
                    disable_devicons = true,
                },
                oldfiles = { disable_devicons = true },
                highlights = { theme = "dropdown" },
            },
            load_extension = {
                "bibtex",
                "luasnip",
            },
            extensions = {
                luasnip = {
                    previewer = false,
                },
                bibtex = {
                    depth = 1,
                    -- Depth for the *.bib file
                    global_files = { '~/Library/texmf/bibtex/bib/Zotero.bib' },
                    -- Path to global bibliographies (placed outside of the project)
                    search_keys = { 'author', 'year', 'title' },
                    -- Define the search keys to use in the picker
                    citation_format = '{{author}} ({{year}}), {{title}}.',
                    -- Template for the formatted citation
                    citation_trim_firstname = true,
                    -- Only use initials for the authors first name
                    citation_max_auth = 2,
                    -- Max number of authors to write in the formatted citation
                    -- following authors will be replaced by "et al."
                    custom_formats = {
                        { id = 'citet', cite_maker = '\\citet{%s}' }
                    },
                    -- Custom format for citation label
                    format = 'citet',
                    -- Format to use for citation label.
                    -- Try to match the filetype by default, or use 'plain'
                    context = true,
                    -- Context awareness disabled by default
                    context_fallback = true,
                    -- Fallback to global/directory .bib files if context not found
                    -- This setting has no effect if context = false
                    wrap = false,
                    -- Wrapping in the preview window is disabled by default
                }
            }
        }
    end,
}
