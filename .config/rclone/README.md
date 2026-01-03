Creates a backup of /mnt/SSD

Credentials are managed via env vars

```bash
touch ~/.config/rclone/credentials.env
echo -e "export RCLONE_CONFIG_GDRIVE_CLIENT_ID=\"client-id\"
export RCLONE_CONFIG_GDRIVE_CLIENT_SECRET=\"client-secret\"" \
>> ~/.config/rclone/credentials.env
rclone config reconnect Gdrive: --auto-confirm
```

Add the backup script to crontab or similar

```bash
# systemd timer
systemctl --user daemon-reload
systemctl --user enable --now rclone-backup.timer
```
