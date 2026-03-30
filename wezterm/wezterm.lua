local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Paths y sistema operativo
config.default_cwd = wezterm.home_dir

local triple = wezterm.target_triple or ""
local is_windows = triple:find("windows") ~= nil
local is_macos = triple:find("darwin") ~= nil
local is_linux = triple:find("linux") ~= nil

-- Programas por sistema
if is_macos then
  config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
end

if is_windows then
  config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-NoLogo" }
  config.default_domain = "WSL:Ubuntu"
  config.wsl_domains = {
    {
      name = "WSL:Ubuntu",
      distribution = "Ubuntu",
      default_cwd = "/home/chris",
    },
  }
end

-- Gráficos
config.enable_kitty_graphics = true
config.term = "wezterm"

-- Fuentes
config.font = wezterm.font('CodeNewRoman Nerd Font')
config.font_size = is_macos and 14 or 13

-- Colores Catppuccin Macchiato
config.colors = {
  foreground = "#CAD3F5",
  background = "#293134",

  selection_fg = "#24273A",
  selection_bg = "#F4DBD6",

  cursor_fg = "#24273A",
  cursor_bg = "#F4DBD6",
  cursor_border = "#F4DBD6",

  ansi = {
    "#494D64", -- black
    "#ED8796", -- red
    "#A6DA95", -- green
    "#EED49F", -- yellow
    "#8AADF4", -- blue
    "#F5BDE6", -- magenta
    "#8BD5CA", -- cyan
    "#B8C0E0", -- white
  },

  brights = {
    "#5B6078", -- bright black
    "#ED8796", -- bright red
    "#A6DA95", -- bright green
    "#EED49F", -- bright yellow
    "#8AADF4", -- bright blue
    "#F5BDE6", -- bright magenta
    "#8BD5CA", -- bright cyan
    "#A5ADCB", -- bright white
  },

  indexed = {
    [16] = "#F5A97F",
    [17] = "#F4DBD6",
  },
}

-- Teclas modificadoras
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Desactivar confirmación al cerrar terminal/panes
config.window_close_confirmation = "NeverPrompt"

-- TUIOS-style modal keybindings
config.keys = {
  -- Ctrl+Esc entra a NORMAL mode
  {
    key = 'Escape',
    mods = 'CTRL',
    action = act.ActivateKeyTable {
      name = 'normal_mode',
      one_shot = false,
      prevent_fallback = true,
    }
  },
}

-- Tablas de teclas normales
config.key_tables = {
  normal_mode = {
    { key = 'h', action = act.ActivatePaneDirection('Left') },
    { key = 'j', action = act.ActivatePaneDirection('Down') },
    { key = 'k', action = act.ActivatePaneDirection('Up') },
    { key = 'l', action = act.ActivatePaneDirection('Right') },

    { key = 'r', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 'm', action = act.ActivateKeyTable { name = 'move_pane', one_shot = false } },

    { key = 'i',     action = act.PopKeyTable },
    { key = 'Enter', action = act.PopKeyTable },

    { key = 's', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'v', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    { key = 'x', action = act.CloseCurrentPane { confirm = false } },
    { key = 'f', action = act.TogglePaneZoomState },

    { key = 't', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'n', action = act.SpawnWindow },

    { key = 'Tab', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT', action = act.ActivateTabRelative(-1) },

    { key = ',', action = act.PromptInputLine {
        description = 'Enter new tab name:',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
    }},

    { key = '1', action = act.ActivateTab(0) },
    { key = '2', action = act.ActivateTab(1) },
    { key = '3', action = act.ActivateTab(2) },
    { key = '4', action = act.ActivateTab(3) },
    { key = '5', action = act.ActivateTab(4) },
    { key = '6', action = act.ActivateTab(5) },
    { key = '7', action = act.ActivateTab(6) },
    { key = '8', action = act.ActivateTab(7) },
    { key = '9', action = act.ActivateTab(8) },

    { key = 'u', mods = 'CTRL', action = act.ScrollByPage(-0.5) },
    { key = 'd', mods = 'CTRL', action = act.ScrollByPage(0.5) },
    { key = 'UpArrow', action = act.ScrollByLine(-1) },
    { key = 'DownArrow', action = act.ScrollByLine(1) },

    { key = '[', action = act.ActivateCopyMode },
    { key = ':', mods = 'SHIFT', action = act.ActivateCommandPalette },

    { key = 'Escape', action = act.Multiple {} },
  },

  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 5 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'Escape', action = act.PopKeyTable },
  },

  move_pane = {
    { key = 'h', action = act.RotatePanes 'CounterClockwise' },
    { key = 'l', action = act.RotatePanes 'Clockwise' },
    { key = 'j', action = act.RotatePanes 'Clockwise' },
    { key = 'k', action = act.RotatePanes 'CounterClockwise' },
    { key = 'Escape', action = act.PopKeyTable },
  },
}

-- Activar NORMAL mode al iniciar
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  wezterm.time.call_after(0.1, function()
    if window and window:gui_window() then
      window:gui_window():perform_action(act.ActivateKeyTable {
        name = 'normal_mode',
        one_shot = false,
        prevent_fallback = true,
      }, pane)
    end
  end)
end)

return config
