local scheme = require("scheme.current")

return {
    ------------------
    ---- HYPRLAND ----
    ------------------

    -- Apps
    terminal                   = "kitty",
    browser                    = "zen-browser",
    editor                     = "code",
    fileExplorer               = "thunar",
    taskManager                = "kitty -e btop",
    discord                    = "vesktop",
    spotify                    = "spotify",
    imglib                     = "imglib-desktop",

    -- Actions
    wallpaperModeWorkspace     = "wallpaper_view",

    -- Blur
    blurEnabled                = true,
    blurSpecialWs              = false,
    blurPopups                 = true,
    blurInputMethods           = true,
    blurSize                   = 8,
    blurPasses                 = 2,
    blurXray                   = false,

    -- Shadow
    shadowEnabled              = true,
    shadowRange                = 15,
    shadowRenderPower          = 4,
    shadowColour               = "rgba(" .. scheme.inversePrimary .. "10)",

    -- Gaps
    workspaceGaps              = 20,
    windowGapsIn               = 5,
    windowGapsOut              = 10,
    singleWindowGapsOut        = 20,

    -- Window styling
    windowOpacity              = 0.95,
    windowRounding             = 15,
    windowBorderSize           = 1,
    activeWindowBorderColour   = "rgba(" .. scheme.primary .. "e6)",
    inactiveWindowBorderColour = "rgba(" .. scheme.onSurfaceVariant .. "11)",

    -- Misc
    volumeStep                 = 10,
    volumeMax                  = 100,
    cursorTheme                = "Bibata-Modern-Classic",
    cursorSize                 = 24,
    sleepGestureCmd            = "systemctl suspend-then-hibernate",

    ------------------
    ---- KEYBINDS ----
    ------------------

    -- Apps
    kbTerminal                 = "SUPER + N",
    kbBrowser                  = "SUPER + Z",
    kbEditor                   = "SUPER + C",
    kbFileExplorer             = "SUPER + E",
    kbDiscord                  = "SUPER + D",
    kbSpotify                  = "SUPER + S",
    kbImglib                   = "SUPER + I",

    -- Actions
    kbSession                  = "SUPER + escape",
    kbNotifications            = "SUPER + B",
    kbWallpaperMode            = "SUPER + H",
    kbLauncher                 = "SUPER + SPACE",
    kbTaskManager              = "CTRL + ALT + Delete",
    kbLock                     = "SUPER + L",
    kbClose                    = "SUPER + X",

    -- Utilities
    kbScreenshotRegion         = "SUPER + SHIFT + S",
    kbColorPicker              = "SUPER + SHIFT + C",

    -- Clipboard and emoji picker
    kbClipboard                = "SUPER + V",
    kbEmoji                    = "SUPER + Period",

    -- Workspaces
    kbMinimize                 = "SUPER + minus",
    kbToggleMinimized          = "SUPER + M",

    -- Move focus
    kbFocusLeft                = "SUPER + left",
    kbFocusRight               = "SUPER + right",
    kbFocusUp                  = "SUPER + up",
    kbFocusDown                = "SUPER + down",

    -- Move window
    kbMoveWindowLeft           = "SUPER + SHIFT + left",
    kbMoveWindowRight          = "SUPER + SHIFT + right",
    kbMoveWindowUp             = "SUPER + SHIFT + up",
    kbMoveWindowDown           = "SUPER + SHIFT + down",

    -- Swap window
    kbSwapWindowLeft           = "SUPER + ALT + left",
    kbSwapWindowRight          = "SUPER + ALT + right",
    kbSwapWindowUp             = "SUPER + ALT + up",
    kbSwapWindowDown           = "SUPER + ALT + down",

    -- Mouse
    kbDragWindow               = "SUPER + mouse:272",
}
