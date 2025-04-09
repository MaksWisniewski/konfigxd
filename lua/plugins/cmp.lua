return { -- Autocompletion
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        { 'hrsh7th/cmp-cmdline', event = "CmdlineEnter" },
        'saadparwaiz1/cmp_luasnip',
        'kdheepak/cmp-latex-symbols',
        'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    opts = function(_, opts)
        local cmp = require 'cmp'

        opts.snippet = {
            expand = function(args)
                require 'luasnip'.lsp_expand(args.body)
            end
        }
        opts.completion = { completeopt = 'menu,menuone,noinsert' }
        opts.mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            -- Scroll the documentation window back / forward
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},

            ['<C-l>'] = cmp.mapping(function()
                require("luasnip").jump(1)
            end, { 'i', 's' }),

            ['<C-h>'] = cmp.mapping(function()
                require("luasnip").jump(-1)
            end, { 'i', 's' }),
        }
        opts.sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'jupyter' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
            {
                name = 'latex_symbols',
                option = {
                    strategy = 2,
                    -- 0 - mixed Show the command and insert the symbol
                    -- 1 - julia Show and insert the symbol
                    -- 2 - latex Show and insert the command
                }
            },
        }

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path', },
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'w', 'wq', 'q', '!' }
                    },
                    keyword_length = 999,
                },
            })
        })

        -- Taken from https://github.com/wincent/wincent/blob/64947cd9efc70844/aspects/nvim/files/.config/nvim/after/plugin/nvim-cmp.lua
        -- Determines whether completion should replace suffix of word or insert in
        -- front of it.
        local confirm = function(entry)
            local behavior = cmp.ConfirmBehavior.Replace
            if entry then
                local completion_item = entry.completion_item
                local newText = ''
                if completion_item.textEdit then
                    newText = completion_item.textEdit.newText
                elseif type(completion_item.insertText) == 'string' and completion_item.insertText ~= '' then
                    newText = completion_item.insertText
                else
                    newText = completion_item.word or completion_item.label or ''
                end

                -- How many characters will be different after the cursor position if we
                -- replace?
                local diff_after = math.max(0, entry.replace_range['end'].character + 1) - entry.context.cursor.col

                -- Does the text that will be replaced after the cursor match the suffix
                -- of the `newText` to be inserted? If not, we should `Insert` instead.
                if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
                    behavior = cmp.ConfirmBehavior.Insert
                end
            end
            cmp.confirm({ select = true, behavior = behavior })
        end

        opts.mapping['<C-y>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    local entry = cmp.get_selected_entry()
                    confirm(entry)
                else
                    fallback()
                end
            end, { 'i', 's' })
    end,
}
