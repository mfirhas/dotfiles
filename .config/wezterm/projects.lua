-- list all files and directories inside ~/github.com/mfirhas
-- select and open it in hxw(helix)

local wezterm = require 'wezterm'

local module = {}

-- source: https://alexplescan.com/posts/2024/08/10/wezterm/

local function project_dirs()
  local projects = {}
  local base_dir = wezterm.home_dir .. '/github.com/mfirhas'
  
  -- List of files/directories to exclude from list
  local exclusions = {
    '.DS_Store',
    '.git',
    'node_modules',
    '.idea',
    '.vscode',
  }
  
  -- check if file/directory is in exclusions
  local function should_exclude(path)
    -- get just the filename/dirname from the full path
    local name = path:match("([^/]+)$")
    for _, exclusion in ipairs(exclusions) do
      if name == exclusion then
        return true
      end
    end
    return false
  end
  
  local success, stdout, stderr = wezterm.run_child_process({
    'ls', '-A', base_dir
  })
  
  if success then
    -- split output by newlines
    for item in stdout:gmatch("[^\r\n]+") do
      local full_path = base_dir .. '/' .. item
      if not should_exclude(full_path) then
        table.insert(projects, full_path)
      end
    end
  end
  
  return projects
end

function module.choose_project()
  local choices = {}
  for _, value in ipairs(project_dirs()) do
    table.insert(choices, { label = value })
  end

  return wezterm.action.InputSelector {
    title = 'Projects',
    choices = choices,
    fuzzy = true,
    action = wezterm.action_callback(function(child_window, child_pane, id, label)
      if label then
        child_pane:send_text('hxw ' .. label .. '\n')
      end
    end),
  }
end

return module