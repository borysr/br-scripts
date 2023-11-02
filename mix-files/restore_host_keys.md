```sh
vi regenerate_host_keys.service
sudo chown root:root regenerate_host_keys.service
sudo cp regenerate_host_keys.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl status regenerate_host_keys
sudo systemctl enable regenerate_host_keys
sudo systemctl status regenerate_host_keys
cat  /etc/machine-id 
sudo truncate -s 0   /etc/machine-id 
cat   /etc/machine-id 
```

```bash
[Unit]
Description=Regenerate SSH host keys
Before=ssh.service
ConditionFileIsExecutable=/usr/bin/ssh-keygen

[Service]
Type=oneshot
ExecStartPre=-/bin/dd if=/dev/hwrng of=/dev/urandom count=1 bs=4096
ExecStartPre=-/bin/sh -c "/bin/rm -f -v /etc/ssh/ssh_host_*_key*"
ExecStart=/usr/bin/ssh-keygen -A -v
ExecStartPost=/bin/systemctl disable regenerate_ssh_host_keys

[Install]
WantedBy=multi-user.target
```
