--------------------
--  LAYER RULES   --
--------------------

hl.layer_rule({ match = { namespace = "waybar" },    blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-.*" }, blur = true, ignore_alpha = 0.5 })

hl.layer_rule({
    match      = { namespace = "^swaync-control-center$" },
    animation  = "slidefade right",
    dim_around = true,
})

hl.layer_rule({ match = { namespace = "rofi" }, dim_around = true })

--------------------
--  WINDOW RULES  --
--------------------

hl.window_rule({ match = { class = "zen" },              opaque = true })
hl.window_rule({ match = { class = "jetbrains-rider" },  opaque = true })
hl.window_rule({ match = { class = "code" },             opaque = true })

hl.window_rule({
    -- Ignore maximize requests from all apps.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
