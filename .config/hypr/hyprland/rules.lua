local vars = require("variables")

--------------------
--  LAYER RULES   --
--------------------

-- Shell
hl.layer_rule({ match = { namespace = "caelestia-(border-exclusion|area-picker)" }, no_anim = true })
hl.layer_rule({ match = { namespace = "caelestia-(drawers|background)" }, animation = "fade" })

--------------------
--  WINDOW RULES  --
--------------------

-- Apply default opacity to all windows except fullscreen
hl.window_rule({ match = { fullscreen = false }, opacity = vars.windowOpacity .. " override" })

-- Center all floating windows except xwayland windows (xwayland popups count as windows)
hl.window_rule({ match = { float = true, xwayland = false }, center = true })

-- Apps
hl.window_rule({ match = { class = "zen" },              opaque = true })
hl.window_rule({ match = { class = "jetbrains-rider" },  opaque = true })
hl.window_rule({ match = { class = "code" },             opaque = true })

-- Vesktop opens a short-lived splash window first. The splash closing empties
-- special:discord, which destroys it, so the real window would land on the
-- active workspace. Pin the class instead of relying on on_created_empty.
hl.window_rule({ match = { class = "vesktop" }, workspace = "special:discord silent" })

-- Idle inhibit while gaming: fullscreen windows and Steam/gamescope/Proton apps
-- keep the shell from locking (gamepad input does not reset the idle timer).
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(gamescope|steam_app_\\d+|steam_proton)$" }, idle_inhibit = "always" })

-- Xwayland drag/popup windows have no class or title, grab focus on map and
-- hand it straight back, flickering focus and fullscreen state.
hl.window_rule({
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Windows re-asserting maximize fight popups over their state.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Endfield's login webview shares the game's class and maps as "Form" at the
-- title screen. Letting it take focus starts a ~40Hz focus/fullscreen fight
-- with the game, which keeps the foreground window unsettled so Steam Remote
-- Play never re-hooks the game after falling back to desktop capture.
hl.window_rule({ match = { class = "^steam_app_3814670559$", title = "^Form$" }, no_focus = true })
hl.window_rule({ match = { class = "^steam_app_3814670559$", title = "^Form$" }, suppress_event = "maximize activatefocus" })

-- Steam Remote Play's desktop-capture rect is the bounding box of the game's
-- X11 windows, not a monitor. This webview is a floating xwayland window, so
-- the center rule above skips it and it keeps its own coordinates -- landing on
-- DP-3 and widening the rect to 5116x1440, which the client letterboxes down to
-- 1920x542. Pin it to the game's monitor to keep the rect at 2560x1440.
hl.window_rule({ match = { class = "^steam_app_3814670559$", title = "^Form$" }, monitor = "DP-2" })
hl.window_rule({ match = { class = "^steam_app_3814670559$", title = "^Form$" }, center = true })

-----------------------
--  WORKSPACE RULES  --
-----------------------

-- App scratchpads: toggling an empty special workspace launches its app.
-- Special workspaces are destroyed when empty (misc.close_special_on_empty),
-- so closing the app makes the next toggle relaunch it.
hl.workspace_rule({ workspace = "special:imglib",  on_created_empty = vars.imglib })
hl.workspace_rule({ workspace = "special:spotify", on_created_empty = vars.spotify })
hl.workspace_rule({ workspace = "special:discord", on_created_empty = vars.discord })
