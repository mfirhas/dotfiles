local status_config = {}

-- top-right status
-- ref: https://alexplescan.com/posts/2024/08/10/wezterm/
local function segments_for_right_status(wezterm, window, pane)
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

  local tab = window:active_tab()
  local pane_count = #tab:panes()
  local pane_count_str = string.format('%d pane', pane_count)
  if pane_count > 1 then
  	pane_count_str = pane_count_str .. 's'
  end

  return {
    pane_count_str,
    bat,
    wezterm.hostname(),
    username,
    wezterm.strftime('%a %-d %b %Y %H:%M'),
  }
end

function status_config.update_status_callback(wezterm)
  wezterm.on('update-status', function(window, pane)
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local segments = segments_for_right_status(wezterm, window, pane)

    local status_color_scheme = window:effective_config().resolved_palette
    -- Note the use of wezterm.color.parse here, this returns
    -- a Color object, which comes with functionality for lightening
    -- or darkening the colour (amongst other things).
    local bg = wezterm.color.parse(status_color_scheme.background)
    local fg = status_color_scheme.foreground

    -- Each powerline segment is going to be coloured progressively
    -- darker/lighter depending on whether we're on a dark/light colour
    -- scheme. Let's establish the "from" and "to" bounds of our gradient.
    local gradient_to, gradient_from = bg, fg
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
end

return status_config
