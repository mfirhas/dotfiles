-- main configuration for wezterm

local config = {}

-- https://formulae.brew.sh/cask/font-code-new-roman-nerd-font
local font = 'CodeNewRoman Nerd Font'
local color_scheme = 'Atom'
local background_color = '1d2129'
local foreground_color = 'ffffff'
local selection_bg = 'c1ddff'
local selection_fg = 'black'

-- @wezterm: wezterm module
-- return wezterm config_builder
function config.init(wezterm)
  local wezterm_cfg = wezterm.config_builder()
  wezterm_cfg.color_scheme = color_scheme
  wezterm_cfg.colors = {
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
  wezterm_cfg.font = wezterm.font(font)
  wezterm_cfg.font_size = 11
  wezterm_cfg.show_new_tab_button_in_tab_bar = false
  wezterm_cfg.tab_max_width = 100
  wezterm_cfg.use_fancy_tab_bar = false
  wezterm_cfg.hide_tab_bar_if_only_one_tab = true
  wezterm_cfg.window_padding = {
    top = 0,
    bottom = 0,
  }

  wezterm_cfg.inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.4,
  }

  return wezterm_cfg
end

return config
