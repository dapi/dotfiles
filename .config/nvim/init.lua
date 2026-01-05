-- require("config")

-- OSC 52 clipboard for SSH (works with Ghostty)
-- Cache for clipboard content (avoids slow OSC52 paste)
local clipboard_cache = { ['+'] = {}, ['*'] = {} }

local function make_osc52_copy(reg)
  local osc52_copy = require('vim.ui.clipboard.osc52').copy(reg)
  return function(lines)
    clipboard_cache[reg] = lines  -- Cache locally
    osc52_copy(lines)             -- Also send to terminal
  end
end

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = make_osc52_copy('+'),
    ['*'] = make_osc52_copy('*'),
  },
  paste = {
    ['+'] = function() return clipboard_cache['+'] end,
    ['*'] = function() return clipboard_cache['*'] end,
  },
}

vim.cmd([[
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/theme.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/plugins-config.vim
source $HOME/.config/nvim/general/autocmd.vim
source $HOME/.config/nvim/general/persistent-undo.vim
source $HOME/.config/nvim/keys/mappings.vim
]])

--"if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
--  "vim.opt.title = true
--  "vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
--"end
