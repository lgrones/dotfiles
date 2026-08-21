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

-----------------------
--  WORKSPACE RULES  --
-----------------------

-- App scratchpads: toggling an empty special workspace launches its app.
-- Special workspaces are destroyed when empty (misc.close_special_on_empty),
-- so closing the app makes the next toggle relaunch it.
hl.workspace_rule({ workspace = "special:imglib",  on_created_empty = vars.imglib })
hl.workspace_rule({ workspace = "special:spotify", on_created_empty = vars.spotify })
hl.workspace_rule({ workspace = "special:discord", on_created_empty = vars.discord })
