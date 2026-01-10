#!/bin/bash

source "$HOME/.config/mail/credentials.env"

cache="/tmp/mailcheck_uids_$USER"

response=$(echo -e "a login $MAIL_USER $MAIL_PASSWORD\nb SELECT INBOX\nc UID SEARCH UNSEEN\nd logout" | \
    openssl s_client -connect "$MAIL_PROVIDER" -quiet 2>/dev/null)

uids=$(echo "$response" | awk '/^\* SEARCH/ {$1=""; $2=""; gsub(/^[ \t\r]+/, ""); print}')

if [ -n "$uids" ]; then
    seen=""
    [ -f "$cache" ] && seen=$(cat "$cache")

    count=0
    for uid in $uids; do
        if ! echo "$seen" | grep -qw "$uid"; then
            count=$((count + 1))
        fi
    done

    if [ "$count" -gt 0 ]; then
        notify-send -a "Mail" -u normal "New Mail" "$count unread message(s)"
    fi

    echo "$uids" > "$cache"
else
    echo "" > "$cache"
fi