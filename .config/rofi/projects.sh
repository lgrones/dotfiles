#!/usr/bin/env bash

root="/mnt/SSD/Coding/"
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
entries="$cache_dir/rofi.projects"

# Find all language-specific files and grab their entry points
# Then generate entries for Rofi to display
generate_entries() {
    declare -A seen

    find "$root" \
    -type d -name node_modules -prune -o \
    -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "*.sln" -o -name "*.slnx" \) \
    -mindepth 1 -maxdepth 4 2>/dev/null \
    | while read -r f; do
        relative=${f#"$root"}   
        top_level=${relative%%/*}
        display_name="$top_level"
        dir=${f%/*}

        case "$f" in
            *.sln|*.slnx)
                key="${display_name}-csharp"
                app=rider; 
                path="$f";
                icon=csharp
                ;;
            *Cargo.toml)
                key="${display_name}-rust"
                app=code; 
                path="$dir"; 
                icon=rust
                ;;
            *package.json)
                key="${display_name}-react"
                app=code; 
                path="$dir"; 
                icon=react
                ;;
        esac

        # Deduplicate
        [[ -n ${seen[$key]} ]] && continue
        seen[$key]=1

        # Return metadata
        printf "%s|%s|%s|%s|%s\n" "$key" "$display_name" "$app" "$path" "$icon"
    done
}

# Build the Rofi string from a cache line
entry_to_rofi() {
    local key display app path icon launch
    IFS='|' read -r key display app path icon <<< "$1"
    launch="coproc (\"$app\" \"$path\" >/dev/null 2>&1)"
    printf "%s\0info\x1f%s|||%s\x1ficon\x1f%s\n" "$display" "$launch" "$key" "$icon"
}

# Send entries to Rofi and exit
if [ -z "$ROFI_INFO" ]; then
    if [[ ! -f "$entries" || ! -s "$entries" ]]; then
        generate_entries > "$entries"
    fi

    while IFS= read -r line; do
        entry_to_rofi "$line"
    done < "$entries"

    exit 0
fi

# This runs when we select an entry in Rofi

regenerate() {
    local selected_key="$1"
    all="$(mktemp)"
    keep="$(mktemp)"
    new="$(mktemp)"

    # Get all new (and old) projects
    generate_entries > "$all"

    # Keep entries from cache whose key still exists, in cache order
    while IFS= read -r line; do
        grep "^${line%%|*}|" "$all" >> "$keep"
    done < "$entries" 

    # Append new entries not already in cache
    while IFS= read -r line; do
        if ! grep -q "^${line%%|*}|" "$keep"; then
            $line >> "$new"
        fi
    done < "$all" 

    cat "$keep" "$new" > "$entries"
    rm "$all" "$keep" "$new"

    # Move the selected entry to the top of the cache
    if [[ -n "$selected_key" ]]; then
        tmp="$(mktemp)"
        grep "^$selected_key|" "$entries" > "$tmp"
        grep -v "^$selected_key|" "$entries" >> "$tmp"
        mv "$tmp" "$entries"
    fi
}

# Launch the project and regenerate the cache file in case a project got deleted/added
launch_str="${ROFI_INFO%%|||*}"
selected_key="${ROFI_INFO##*|||}"
(nohup bash -c "$launch_str" >/dev/null 2>&1 && regenerate "$selected_key" >/dev/null 2>&1) &