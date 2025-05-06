local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config = {
  adjust_window_size_when_changing_font_size = false,
  animation_fps  = 120,
  audible_bell = "Disabled",
  automatically_reload_config = true,
  check_for_updates = false,
  cursor_blink_rate = 500,
  default_cursor_style = "BlinkingBar",
  enable_tab_bar = false,
  font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" }),
  font_size = 16,
  front_end = "WebGpu",
  hide_tab_bar_if_only_one_tab = false,
  initial_cols = 120,
  initial_rows = 40,
  prefer_egl = true,
  macos_window_background_blur = 40,
  max_fps = 120,
  native_macos_fullscreen_mode = false,
  tab_and_split_indices_are_zero_based = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_background_opacity = 0.3,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "TITLE | RESIZE",
}

config.colors = {}

config.window_padding = {
  top = 0,
  bottom = 0,
  left = 0,
  right = 0,
}

config.leader = {
  mods = "CMD",
  key = "a",
  timeout_milliseconds = 2000,
}

config.keys = {
  {
    mods = "LEADER",
    key = "s",
    action = wezterm.action.QuickSelect,
  },
  {
    mods = "LEADER",
    key = "d",
    action = wezterm.action.ActivateCopyMode,
  },
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "m",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = ",",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "LEADER",
    key = ".",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection "Left"
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection "Down"
 },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection "Right"
  },
  {
    mods = "LEADER",
    key = "i",
    action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
    mods = "LEADER",
    key = "o",
    action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
    mods = "LEADER",
    key = "p",
    action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },
  {
    mods = "LEADER",
    key = "[",
    action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
    mods = "LEADER",
    key = "u",
    action = wezterm.action.ToggleFullScreen,
  },
  {
    mods = "LEADER",
    key = "z",
    action = wezterm.action_callback(function(window, pane)
      local current_tab = window:active_tab()
      for _, tab in ipairs(window:tabs()) do
        if tab:tab_id() ~= current_tab:tab_id() then
          window:perform_action(wezterm.action.CloseTab { confirm = false }, tab:active_pane())
        end
      end
    end),
  },
}

--wezterm.on("update-right-status", function(window, _)
  --local SOLID_LEFT_ARROW = ""
  --local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  --local prefix = ""
--
  --if window:leader_is_active() then
    --prefix = " " .. utf8.char(0x1f30a) -- ocean wave
    --SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  --end
--
  --if window:active_tab():tab_id() ~= 0 then
    --ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  --end -- arrow color based on if tab is first pane
--
  --window:set_left_status(wezterm.format({
    --{ Background = { Color = "#b7bdf8" } },
    --{ Text = prefix },
    --ARROW_FOREGROUND,
    --{ Text = SOLID_LEFT_ARROW },
  --}))
--end)

wezterm.on('update-right-status', function(window, pane)
  local tab_count = #window:tabs()
  window:set_right_status("Tabs: " .. tab_count)
end)

return config
