-- Idle inhibit while gaming: fullscreen windows and Steam/gamescope/Proton apps
-- keep the shell from locking (gamepad input does not reset the idle timer).
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(gamescope|steam_app_\\d+|steam_proton)$" }, idle_inhibit = "always" })
