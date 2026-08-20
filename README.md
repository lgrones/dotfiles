# dotfiles

Bare git repo, work tree `$HOME`. Arch + Hyprland (Lua config) + caelestia.

```sh
git clone --bare git@github.com:lgrones/dotfiles.git "$HOME/.dotfiles"
alias dot='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
dot config status.showUntrackedFiles no
dot checkout
```

`status.showUntrackedFiles=no` is required — without it `git status` lists all of `$HOME`.
New files must therefore be added by explicit path; `dot add -A` will not pick them up.

## Requires my caelestia shell fork — not upstream

The shell config in `.config/caelestia/shell.json` sets keys that **only exist in
[`lgrones/shell`](https://github.com/lgrones/shell), branch `leah`**. On upstream
caelestia-shell these keys are silently ignored and the config is wrong, not broken:

| `shell.json` key | Needs fork commit |
|---|---|
| `session.order` — reorder the session (power) menu items | `ee198b3e` feat(session): Add config to reorder session items |
| `launcher.actions[].name == "Light/Dark"` — mode toggle action | `82669f51` feat(actions): Add dark/light mode toggle |

The branch is 8 commits ahead of `upstream/main` (base `b1c9bbd0`); the rest are
dashboard/radius fixes. Build and install it, not the AUR/upstream shell:

```sh
git clone -b leah git@github.com:lgrones/shell.git ~/repos/caelestia-shell
# then follow that repo's README (it documents the fork workflow at the top)
```

Installed shell lands in `~/.config/quickshell/caelestia` — that directory is a build
artifact, root-owned, and deliberately **not** tracked here.

The **CLI is plain upstream**: Arch package `caelestia-cli` (`/usr/bin/caelestia`).
No fork needed. `~/repos/caelestia-cli` is just a reference clone with no local commits.

## Theming — everything derives from the caelestia scheme

Scheme lives in `~/.local/state/caelestia/scheme.json` (currently `dynamic`, wallpaper-derived).
`caelestia scheme set …` rewrites every consumer. Nothing in this repo hardcodes a palette.

Three mechanisms, in order of preference:

**1. caelestia built-in appliers** — no config needed here, they are on by default:
gtk (`gtk.css`, `thunar.css`), qt via qtengine, btop, cava, fuzzel, htop, nvtop,
discord, spicetify, chromium, hypr (`.config/hypr/scheme/current.lua`).
Their output is generated, so it is gitignored. `.config/btop/btop.conf` just points at
`themes/caelestia.theme`.

**2. User templates** in `.config/caelestia/templates/` → rendered to
`~/.local/state/caelestia/theme/<same name>` on every scheme change. `{{ colour.hex }}`
placeholders; any key from `scheme.json` works, including the catppuccin-style aliases
(`text`, `surface2`, `overlay0`, `red`, `peach`, `mauve`, …) and `term0`–`term15`.

One deliberate exception: in `zsh-syntax-highlighting.zsh`, the `green` / `red` / `maroon`
slots are **pinned to fixed hex, not templated**. Those three carry the does-this-command-
exist signal, and the wallpaper-derived `dynamic` scheme happily maps `red` to a blue
(`#9ab1ff`) and `green` to a cyan. Decoration in that file still follows the scheme.

| Template | Consumed by |
|---|---|
| `kitty.conf` | `include`d from `.config/kitty/kitty.conf` |
| `zen-userChrome.css`, `zen-userContent.css` | `.config/zen/user*.css` are symlinks to the rendered files |
| `zsh-syntax-highlighting.zsh` | sourced from `.zshrc` after the plugin |

**3. postHook** in `.config/caelestia/cli.json`, for things that can't be templated:
reloads kitty, refreshes spicetify, and runs `.config/caelestia/openrgb-sync.sh`.
That script reads `primary` out of `$SCHEME_COLOURS` and calls
`openrgb --mode static --color <hex>` — OpenRGB profiles are binary `.orp` files and
cannot be generated, so the profile autoload is disabled in `.config/OpenRGB/OpenRGB.json`.

`starship.toml` uses ANSI palette slots rather than hex, so it follows the scheme via the
terminal sequences caelestia emits — no template required.

## Non-caelestia dependencies

- **Cursor:** `Bibata-Modern-Classic` — AUR `bibata-cursor-theme-bin`. Referenced from
  `.gtkrc-2.0`, `.config/gtk-{3,4}.0/settings.ini`,
  `.config/hypr/variables.lua`, `.local/share/icons/default/index.theme`,
  `.local/share/nwg-look/gsettings`, and dconf `/org/gnome/desktop/interface/cursor-theme`.
- **GTK:** `adw-gtk3-dark` + icon theme `YAMIS` (set via `cli.json` `theme.iconTheme`).
- **Qt:** qtengine, via `QT_QPA_PLATFORMTHEME` in `.config/hypr/hyprland/env.lua`.
  `qt5ct`, `qt6ct` and `Kvantum` are gone — packages and configs both. `/etc/environment`
  had their env vars commented out, so nothing had been reading them for a while. If you
  ever want them back, reinstall and recover the configs from history at `1d1bc5d`.
- **VS Code:** theme comes from `soramanew.caelestia-vscode-integration`, installed from the
  `.vsix` in [caelestia-dots/caelestia](https://github.com/caelestia-dots/caelestia/tree/main/vscode).
  It watches `scheme.json` and regenerates its own theme JSON. `.config/Code/` is not tracked
  (large app state + Settings Sync is enabled).

## Deliberately absent

Removed, not missing. Everything here is recoverable from history if a decision turns out wrong.

| Gone | Why | Recover from |
|---|---|---|
| `waybar`, `swaync` | caelestia shell provides the bar and notifications. Packages were already uninstalled; only orphan configs remained. | `1d1bc5d` |
| `rofi` | `fuzzel` is caelestia's launcher. Package already gone. Took the custom bluetooth / clipboard / launcher / powermenu / windowswitcher scripts with it. | `1d1bc5d` |
| `xsettingsd` | Binary was never installed and nothing launched it. GTK settings come from `gtk-{3,4}.0/settings.ini` + dconf. | `1d1bc5d` |
| `qt5ct`, `qt6ct`, `Kvantum` | Superseded by qtengine. | `1d1bc5d` |
| `.themes/catppuccin-mocha-lavender-standard*` | 2.3M of GTK theme with no consumer left after the caelestia migration. | `1d1bc5d` |

## Not tracked on purpose

See `.gitignore`. Summary: caelestia-generated output, `*.bak`, `theme-backup-*/`, and the
two large app-state dirs `.config/Code/` and `.config/inkscape/`.
