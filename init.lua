-- The below are taken from NormalVim/NormalVim

local function load_source(source)
    local status_ok, error = pcall(require, source)
    if not status_ok then
      vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. error)
      vim.cmd([[e ~/.config/nvim]])
    end
  end
  
  local function load_colorscheme_async(colorscheme)
    vim.defer_fn(function()
      if vim.g.default_colorscheme then
        if not pcall(vim.cmd.colorscheme, colorscheme) then
            vim.notify("Error setting up colorscheme: " .. colorscheme, vim.log.levels.ERROR)
        end
      end
    end, 0)
  end
  
  -- Call the functions defined above.
  load_source("options")
  load_source("lazy-plugins")
  load_colorscheme_async(vim.g.default_colorscheme)
  load_source("mappings")