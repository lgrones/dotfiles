local vars = require("variables")
local wallpaperMode = require("utils.wallpaper_mode")

-- Actions
hl.bind(vars.kbSession, hl.dsp.global("caelestia:session"))
hl.bind(vars.kbNotifications, hl.dsp.global("caelestia:sidebar"))
hl.bind(vars.kbWallpaperMode, wallpaperMode.toggle)

hl.bind(vars.kbTerminal, hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.kbBrowser, hl.dsp.exec_cmd(vars.browser))
hl.bind(vars.kbEditor, hl.dsp.exec_cmd(vars.editor))
hl.bind(vars.kbFileExplorer, hl.dsp.exec_cmd(vars.fileExplorer))
hl.bind(vars.kbDiscord, hl.dsp.exec_cmd(vars.discord))
hl.bind(vars.kbTaskManager, hl.dsp.exec_cmd(vars.taskManager))

hl.bind(vars.kbLauncher, hl.dsp.global("caelestia:launcher"))
hl.bind(vars.kbLock, hl.dsp.global("caelestia:lock"))
hl.bind(vars.kbScreenshotRegion, hl.dsp.global("caelestia:screenshot"))
hl.bind(vars.kbClipboard, hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
hl.bind(vars.kbEmoji, hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

hl.bind(vars.kbColorPicker, hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(vars.kbClose, hl.dsp.window.close())

-- The old config bound `minus` twice (movetoworkspacesilent special:minimized,
-- then movetoworkspace 1). Hyprland runs both, top to bottom, so this keeps the
-- exact same behavior in one bind.
hl.bind(vars.kbMinimize, function()
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
    hl.dispatch(hl.dsp.window.move({ workspace = 1 }))
end)

hl.bind(vars.kbToggleMinimized, hl.dsp.workspace.toggle_special("minimized"))

-- Move focus
hl.bind(vars.kbFocusLeft,  hl.dsp.focus({ direction = "left" }))
hl.bind(vars.kbFocusRight, hl.dsp.focus({ direction = "right" }))
hl.bind(vars.kbFocusUp,    hl.dsp.focus({ direction = "up" }))
hl.bind(vars.kbFocusDown,  hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(vars.kbMoveWindowLeft,  hl.dsp.window.move({ direction = "left" }))
hl.bind(vars.kbMoveWindowRight, hl.dsp.window.move({ direction = "right" }))
hl.bind(vars.kbMoveWindowUp,    hl.dsp.window.move({ direction = "up" }))
hl.bind(vars.kbMoveWindowDown,  hl.dsp.window.move({ direction = "down" }))

-- Swap window
hl.bind(vars.kbSwapWindowLeft,  hl.dsp.window.swap({ direction = "left" }))
hl.bind(vars.kbSwapWindowRight, hl.dsp.window.swap({ direction = "right" }))
hl.bind(vars.kbSwapWindowUp,    hl.dsp.window.swap({ direction = "up" }))
hl.bind(vars.kbSwapWindowDown,  hl.dsp.window.swap({ direction = "down" }))

-- Move windows with SUPER + LMB
hl.bind(vars.kbDragWindow, hl.dsp.window.drag(), { mouse = true })

-- Media / brightness keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.global("caelestia:mediaNext"),   { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.global("caelestia:mediaPrev"),   { locked = true })
hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.global("caelestia:mediaToggle"), { locked = true })
