local virtual_env = function()
    local conda_env = os.getenv('CONDA_DEFAULT_ENV')
    local venv_path = os.getenv('VIRTUAL_ENV')

    if venv_path == nil then
        if conda_env == nil then
            return ""
        else
            return string.format("  %s (conda)", conda_env)
        end
    else
        local venv_name = vim.fn.fnamemodify(venv_path, ':h:t')
        return string.format("  %s (venv)", venv_name)
    end
end

-- local vimtex_status = function()
--     local icon = "-"
--     if vim.g.vimtex_compiler_status == 0 then
--         icon = "⭘"
--     elseif vim.g.vimtex_compiler_status == -1 then
--         icon = "󰅚"
--     elseif vim.g.vimtex_compiler_status == 1 then
--         icon = "󰑮"
--     elseif vim.g.vimtex_compiler_status == 2 then
--         icon = "󰄴"
--     end
--     return string.format("%s VimTex", icon)
-- end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'gruvbox-material',
            icons_enabled = true,
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    color = { gui = 'bold' },
                    fmt = function(str, _)
                        return string.lower(str)
                    end,
                }
            },
            lualine_b = {
                { 'branch', icon = '' },
                'diff',
            },
            lualine_x = {
                'overseer',
                { 'filetype', icon = nil },
            },
            lualine_y = {
                {
                    virtual_env,
                    cond = function() return vim.bo.filetype == "python" end, 
                },
                {
                    vimtex_status,
                    cond = function() return vim.bo.filetype == "tex" end,
                },
            },
        },
    }
}
