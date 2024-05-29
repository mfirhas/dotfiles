local wezterm = require 'wezterm'

local font = 'CodeNewRoman Nerd Font'
local color_scheme = 'Atom'
local background_color = '1d2129'
local foreground_color = 'ffffff'
local selection_bg = 'c1ddff'
local selection_fg = 'black'

local config = wezterm.config_builder()
config.color_scheme = color_scheme
config.colors = {
    tab_bar = {
      active_tab = {
        bg_color = background_color,
        fg_color = foreground_color,
      },
      inactive_tab_hover = {
        bg_color = background_color,
        fg_color = foreground_color,
      }
    },
    background = background_color,
    foreground = foreground_color,
    selection_bg = selection_bg,
    selection_fg = selection_fg,
  }
config.font = wezterm.font(font)
config.font_size = 12
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 100
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  top = 0,
  bottom = 0,
}

config.keys = {
  {
    key = '\'',
    mods = 'CTRL',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = ']',
    mods = 'CTRL',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

return config
