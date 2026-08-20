-- Wallpaper mode: stash every window on a normal workspace into a special
-- workspace so the wallpaper is visible, then put them all back where they
-- were. Replaces the old wallpaper-mode.sh (which needed jq and /tmp state
-- files because each run was a fresh process).

local vars = require("variables")

local special = "special:" .. vars.wallpaperModeWorkspace

-- address -> workspace id, filled on hide, consumed on restore
local saved = {}

local function move_silent(window, workspace)
    hl.dispatch(hl.dsp.window.move({ workspace = workspace, window = window, follow = false }))
end

-- Empty table rather than an error when the special workspace doesn't exist yet
local function stashed()
    local ok, windows = pcall(hl.get_workspace_windows, special)
    if not ok or type(windows) ~= "table" then return {} end
    return windows
end

local function hide()
    saved = {}
    for _, w in ipairs(hl.get_windows()) do
        if w.workspace.id > 0 then
            saved[w.address] = w.workspace.id
            move_silent(w, special)
        end
    end
end

local function restore()
    for _, w in ipairs(stashed()) do
        -- A config reload wipes `saved`, so fall back to workspace 1
        move_silent(w, saved[w.address] or 1)
    end
    saved = {}
end

local function toggle()
    if #stashed() > 0 then restore() else hide() end
end

return {
    toggle = toggle,
    hide = hide,
    restore = restore,
}
