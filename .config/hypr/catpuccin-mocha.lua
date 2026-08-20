--------------------
--     COLORS     --
--------------------
-- Catppuccin Mocha palette.
-- Hyprland accepts colors as strings: "rgb(rrggbb)" / "rgba(rrggbbaa)".
--
-- Usage:
--   C.lavender          --> "rgb(b4befe)"      (was $lavender)
--   C.hex.lavender      --> "b4befe"           (was $lavenderAlpha)
--   C.rgba("crust", "ee") --> "rgba(11111bee)" (was rgba($crustAlphaee))

local hex = {
    rosewater = "f5e0dc",
    flamingo  = "f2cdcd",
    pink      = "f5c2e7",
    mauve     = "cba6f7",
    red       = "f38ba8",
    maroon    = "eba0ac",
    peach     = "fab387",
    yellow    = "f9e2af",
    green     = "a6e3a1",
    teal      = "94e2d5",
    sky       = "89dceb",
    sapphire  = "74c7ec",
    blue      = "89b4fa",
    lavender  = "b4befe",
    text      = "cdd6f4",
    subtext1  = "bac2de",
    subtext0  = "a6adc8",
    overlay2  = "9399b2",
    overlay1  = "7f849c",
    overlay0  = "6c7086",
    surface2  = "585b70",
    surface1  = "45475a",
    surface0  = "313244",
    base      = "1e1e2e",
    mantle    = "181825",
    crust     = "11111b",
}

local C = { hex = hex }

for name, value in pairs(hex) do
    C[name] = "rgb(" .. value .. ")"
end

--- Build an "rgba(...)" string from a palette name and a 2-digit hex alpha.
---@param name string palette entry, e.g. "crust"
---@param alpha string two hex digits, e.g. "ee"
---@return string
function C.rgba(name, alpha)
    return "rgba(" .. hex[name] .. alpha .. ")"
end

return C
