-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Function to increase font size by 2 points instead of the built-in
-- scaling of font size by 0.9 or 1.1.
local function increase_font_size(window, pane)
    local overrides = window:get_config_overrides() or {}
    local current_size = overrides.font_size or
                             window:effective_config().font_size
    overrides.font_size = current_size + 2.0
    window:set_config_overrides(overrides)
    return false -- Don't propagate the event
end

-- Function to decrease font size by 2 points
local function decrease_font_size(window, pane)
    local overrides = window:get_config_overrides() or {}
    local current_size = overrides.font_size or
                             window:effective_config().font_size
    overrides.font_size = current_size - 2.0
    window:set_config_overrides(overrides)
    return false -- Don't propagate the event
end

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then config = wezterm.config_builder() end

config.font = wezterm.font_with_fallback {'Terminess Nerd Font', 'Spot Mono'}
config.font_size = 20

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox dark, medium (base16)'

-- Hide the tab bar
config.hide_tab_bar_if_only_one_tab = true

-- Don't resize the window when adjusting dfont size
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"

config.keys = {
    {
        key = '=',
        mods = 'CTRL',
        action = wezterm.action_callback(increase_font_size)
    }, {
        key = '-',
        mods = 'CTRL',
        action = wezterm.action_callback(decrease_font_size)
    }, {key = '0', mods = 'CTRL', action = act.ResetFontSize}
}

-- and finally, return the configuration to wezterm
return config
