local vars = require("variables")

hl.on("hyprland.start", function()
    -- Auth
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Auto delete trash 30 days old
    hl.exec_cmd("trash-empty 30")

    -- Cursors
    hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)

    -- Forward bluetooth media commands to MPRIS
    hl.exec_cmd("mpris-proxy")

    -- Set fan colors from the current caelestia scheme
    hl.exec_cmd("~/.config/caelestia/openrgb-sync.sh")

    -- Start shell
    hl.exec_cmd("caelestia shell -d")
end)