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
