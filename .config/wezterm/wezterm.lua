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
config.font_size = 11
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 100
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  top = 0,
  bottom = 0,
}

function split_pane(pane, direction, pane_size) 
  pane:split({
      direction = direction,
      size = pane_size,
  })
end

-- split panes in multiple directions, and toggle them, used for toggle 1 extra pane
function toggle_split(direction)
  local pane_size = 0.5
  if direction == "Left" then
    pane_size = 0.3
  elseif direction == "Right" then
    pane_size = 0.7
  end

  return function(_, pane)

    local tab = pane:tab()
    local panes = tab:panes_with_info()

    if #panes == 1 then
      split_pane(pane, direction, pane_size)
    elseif direction == 'Top' or direction == 'Left' then
      if not panes[2].is_zoomed then
        panes[2].pane:activate()
        tab:set_zoomed(true)
      elseif panes[2].is_zoomed then
        tab:set_zoomed(false)
        panes[1].pane:activate()
      end
    else
      if not panes[1].is_zoomed then
        panes[1].pane:activate()
        tab:set_zoomed(true)
      elseif panes[1].is_zoomed then
        tab:set_zoomed(false)
        panes[2].pane:activate()
      end
    end

  end

end

config.keys = {
  -- Open new pane at bottom, starting new session
  {
    key = '"',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Open new pane at right, starting new session
  {
    key = '}',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Open new pane at top, starting new session
  {
    key = '|',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(_, pane)
      pane:split({
          direction = "Top",
          size = 0.5,
          domain = 'CurrentPaneDomain',
      })
    end),
  },
  -- Open new pane at left, starting new session
  {
    key = '{',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(_, pane)
      pane:split({
          direction = "Left",
          size = 0.5,
          domain = 'CurrentPaneDomain',
      })
    end),
  },

  -- Toggle pane at bottom
  {
    key = '\'',
    mods = 'CTRL',
    action = wezterm.action_callback(toggle_split("Bottom")),
  },

  -- Toggle pane at right
  {
    key = ']',
    mods = 'CTRL',
    action = wezterm.action_callback(toggle_split("Right")),
  },

  -- Toggle pane at top
  {
    key = '\\',
    mods = 'CTRL',
    action = wezterm.action_callback(toggle_split("Top")),
  },

  -- Toggle pane at left
  {
    key = '[',
    mods = 'CTRL',
    action = wezterm.action_callback(toggle_split("Left")),
  },

  -- close current pane
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  { key = '/', mods = 'CTRL', action = wezterm.action.PaneSelect },
  {
    key = '=',
    mods = 'ALT',
    action = wezterm.action.ToggleFullScreen,
  },
  -- toggle current pane full screen
  {
    key = ';',
    mods = 'CTRL',
    action = wezterm.action.TogglePaneZoomState,
  },
}

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.4,
}

return config
