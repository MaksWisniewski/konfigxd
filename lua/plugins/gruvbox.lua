return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
        terminal_colors = false, -- add neovim terminal colors
        undercurl = false,
        underline = true,
        bold = true,
        italic = {
            strings = false,
            emphasis = true,
            comments = true,
            operators = false,
            folds = false,
        },
        strikethrough = false,
        invert_selection = false,
        inverse = true,    -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        overrides = {
            ColorColumn = { bg = "#171717" },
            SignColumn = { bg = "#070505" },
            NonText = { fg = "#191716" }, -- indentline
            Whitespace = { fg = "#191716" },
            IblScope = { fg = "#7c6f64" },
            Normal = { bg = "#070505" },
            GruvboxYellowSign = { bg = "#070505" },
            GruvboxRedSign = { bg = "#070505" },
            GruvboxBlueSign = { bg = "#070505" },
            RenderMarkdownCode = { bg = "#312e2c" },
            -- DapUIStop = { bg = "#070505" },
            -- DapUIStepInto = { bg = "#070505" },
            -- DapUIStepOver = { bg = "#070505" },
            -- DapUIStepOut = { bg = "#070505" },
            -- DapUIRestart = { bg = "#070505" },
            -- DapUIStepBack = { bg = "#070505" },
            -- DapUIPlayPause = { bg = "#070505" },
        }
    }
}