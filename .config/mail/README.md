Checks for new mails via IMAP

Credentials are managed via env vars

```bash
touch ~/.config/mail/credentials.env
chmod 600 ~/.config/mail/credentials.env
echo -e "MAIL_USER=\"mail@mail.com\"
MAIL_PASSWORD=\"password\"
MAIL_PROVIDER=\"server:port\"" \
>> ~/.config/mail/credentials.env
```

Add the script to crontab or similar

```bash
# systemd timer
systemctl --user daemon-reload
systemctl --user enable --now mailcheck.timer
```
