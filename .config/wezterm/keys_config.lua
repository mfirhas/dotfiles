local projects = require 'projects'

local keys_config = {}

local function split_pane(pane, direction, pane_size)
  pane:split({
      direction = direction,
      size = pane_size,
  })
end

-- split panes in multiple directions, and toggle them, used for toggle 1 extra pane
local function toggle_split(direction)
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

function keys_config.init(wezterm, wezterm_config)
  wezterm_config.keys = {
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
        split_pane(pane, "Top", 0.5)
      end),
    },
    -- Open new pane at left, starting new session
    {
      key = '{',
      mods = 'CTRL|SHIFT',
      action = wezterm.action_callback(function(_, pane)
        split_pane(pane, "Left", 0.5)
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

    -- close current tab
    {
      key = 'W',
      mods = 'CMD|SHIFT',
      action = wezterm.action.CloseCurrentTab { confirm = true },
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

    -- open project selector
    {
      key = 'k',
      mods = 'CTRL',
      action = projects.choose_project(),
    },
  }
end

return keys_config
