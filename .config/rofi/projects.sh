#!/usr/bin/env bash

root="/mnt/SSD/Coding/"
declare -A seen

if [ -z "$ROFI_INFO" ]; then
    find ${root} \
    -type d -name node_modules -prune -o \
    -type f \( -name "package.json" -o -name "Cargo.toml" -o -name "*.sln" -o -name "*.slnx" \) \
    -mindepth 1 -maxdepth 4 2>/dev/null \
    | while read -r f; do
       case "$f" in
            *.sln|*.slnx)
                display_name=$(basename "$f" .${f##*.})
                launch="rider ${f}"
                icon="text-csharp"
                key="${display_name}-csharp"
                ;;
            *Cargo.toml)
                relative=${f#"$root"}
                top_level=${relative%%/*}
                display_name="$top_level"
                dirname=$(dirname $f)
                launch="code ${dirname}"
                icon="text-rust"
                key="${display_name}-rust"
                ;;
            *package.json)
                relative=${f#"$root"}
                top_level=${relative%%/*}
                display_name="$top_level"
                dirname=$(dirname $f)
                launch="code ${dirname}"
                icon="text-javascript"
                key="${display_name}-react"
                ;;
        esac

        [[ -n "${seen[$key]}" ]] && continue
        seen[$key]=1

        printf "%s\0info\x1f%s\x1ficon\x1f%s\n" "$display_name" "$launch" "$icon"
    done
    exit 0
fi

nohup bash -c "$ROFI_INFO" >/dev/null 2>&1 &
