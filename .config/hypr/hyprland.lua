-- https://wiki.hypr.land/Configuring/
--
-- Lua config (Hyprland >= 0.55). The old hyprlang *.conf files are kept next to
-- this one as a fallback; Hyprland loads hyprland.lua if it exists.

local C = require("catpuccin-mocha")

require("animations")
require("apps")
require("decorations")
require("env")
require("inputs")
require("keybindings")
require("monitors")
require("rules")

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 8,
        border_size = 2,

        col = {
            active_border   = C.lavender,
            inactive_border = C.rgba("overlay0", "aa"),
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    dwindle = {
        preserve_split = true, -- You probably want this
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
