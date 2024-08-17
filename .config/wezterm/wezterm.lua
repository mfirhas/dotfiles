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
}

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.4,
}

-- top-right status
-- ref: https://alexplescan.com/posts/2024/08/10/wezterm/
local function segments_for_right_status(window, pane)
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    local charge_val = b.state_of_charge
    local charge_symbol = '🔋'
    if charge_val < 0.3 then
      charge_symbol = '🪫'
    end
    bat = charge_symbol .. string.format('%.0f%%', charge_val * 100)
  end

  local username = os.getenv('USER') or os.getenv('LOGNAME') or os.getenv('USERNAME')

  return {
    bat,
    window:active_workspace(),
    wezterm.hostname(),
    username,
    wezterm.strftime('%a %-d %b %Y %H:%M'),
  }
end

wezterm.on('update-status', function(window, pane)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window, pane)

  local status_color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(status_color_scheme.background)
  local fg = status_color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to, gradient_from = bg
  -- if appearance.is_dark() then
    gradient_from = gradient_to:lighten(0.2)
  -- else
    -- gradient_from = gradient_to:darken(0.2)
  -- end

  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = '#333333' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config
