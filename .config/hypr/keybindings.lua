--------------------
--   SHORTCUTS    --
--------------------

local apps = require("apps")

local mainMod = "SUPER"

hl.bind(mainMod .. " + space",          hl.dsp.exec_cmd(apps.menu))
hl.bind(mainMod .. " + escape",         hl.dsp.exec_cmd(apps.powerMenu))
hl.bind(mainMod .. " + Z",              hl.dsp.exec_cmd(apps.browser))
hl.bind(mainMod .. " + X",              hl.dsp.window.close())
hl.bind(mainMod .. " + V",              hl.dsp.exec_cmd(apps.clipboard))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd(apps.notifications))
hl.bind(mainMod .. " + N",              hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + D",              hl.dsp.exec_cmd(apps.discord))
hl.bind(mainMod .. " + H",              hl.dsp.exec_cmd(apps.wallpaperMode))
hl.bind(mainMod .. " + L",              hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Q",              hl.dsp.exec_cmd(apps.bluetooth))
hl.bind(mainMod .. " + W",              hl.dsp.exec_cmd(apps.windowSwitcher))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(apps.fileManager))
hl.bind(mainMod .. " + SHIFT + S",      hl.dsp.exec_cmd(apps.screenshot))
hl.bind("CTRL + ALT + delete",          hl.dsp.exec_cmd(apps.taskmanager))

-- The old config bound `minus` twice (movetoworkspacesilent special:minimized,
-- then movetoworkspace 1). Hyprland runs both, top to bottom, so this keeps the
-- exact same behavior in one bind.
hl.bind(mainMod .. " + minus", function()
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
    hl.dispatch(hl.dsp.window.move({ workspace = 1 }))
end)

hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("minimized"))

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Swap window
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Move windows with mainMod + LMB
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Media / brightness keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
