-- Main config file

local wezterm = require 'wezterm'

local config = require 'config'
local keys_config = require 'keys_config'
local status_config = require 'status_config'

-- Initialize wezterm configuration
local wezterm_config = config.init(wezterm)

-- Initialize keys config
keys_config.init(wezterm, wezterm_config)

-- Register update status callback
status_config.update_status_callback(wezterm)

return wezterm_config
