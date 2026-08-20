--------------------
--  DEFAULT APPS  --
--------------------

local home = os.getenv("HOME")
local rofi = home .. "/.config/rofi"

local apps = {
    terminal        = "kitty",
    fileManager     = "thunar",
    taskmanager     = "kitty -e btop",
    notifications   = "swaync-client -t -sw",
    browser         = "zen-browser",
    discord         = "discord",
    screenshot      = [[grim -g "$(slurp)" - | wl-copy]],
    rofi            = rofi,
    menu            = rofi .. "/launcher/launcher.sh",
    powerMenu       = rofi .. "/powermenu/powermenu.sh",
    windowSwitcher  = rofi .. "/windowswitcher/windowswitcher.sh",
    clipboard       = rofi .. "/clipboard/clipboard.sh",
    bluetooth       = rofi .. "/bluetooth/bluetooth.sh",
    wallpaperMode   = home .. "/.config/hypr/wallpaper-mode.sh",
}

--------------------
--  STARTUP APPS  --
--------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("openrgb -p catppuccin.orp")
    hl.exec_cmd("hyprctl setcursor catppuccin-mocha-lavender-cursors 24")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("/home/leah/.nvm/versions/node/v24.12.0/bin/node /home/leah/apps/Danbooru/server.js")
    hl.exec_cmd("fcitx5 -d") -- Japanese IME
end)

return apps
