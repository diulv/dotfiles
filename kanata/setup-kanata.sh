#get kanata

sudo wget -O /usr/local/bin/kanata https://github.com/jtroo/kanata/releases/download/v1.7.0/kanata
sudo chown root:kanata /usr/local/bin/kanata
sudo chmod 754 /usr/local/bin/kanata

#setup dedicated group for kernel mode
sudo groupadd uinput

sudo touch /etc/udev/rules.d/99-input.rules
sudo echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/50-kanata.rules > /dev/null

sudo udevadm control --reload-rules && sudo udevadm trigger

sudo modprobe uinput

#create kanata user
sudo useradd --no-create-home --groups input,uinput --shell /bin/false --user-group kanata

# create systemd unit
sudo echo "[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata
Wants=modprobe@uinput.service
After=modprobe@uinput.service

[Service]
Type=simple
User=kanata
ExecStart=/usr/local/bin/kanata --quiet --cfg ~/dotfiles/kanata/kanata.kbd
Restart=no
# Security
CapabilityBoundingSet=
DeviceAllow=/dev/uinput rw
DeviceAllow=char-input
DeviceAllow=/dev/stdin
DevicePolicy=strict
PrivateDevices=true
BindPaths=/dev/uinput
BindReadOnlyPaths=/dev/stdin
BindReadOnlyPaths=/dev/input/
InaccessiblePaths=/dev/shm
LockPersonality=true
NoNewPrivileges=true
PrivateTmp=true
PrivateNetwork=true
PrivateUsers=true
# The following can not be enabled, otherwise Kanata can not open /dev/uinput.
# More hardening would require to explicitly list allowed system calls.
#ProtectClock=true
ProtectHome=true
ProtectHostname=true
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectKernelLogs=true
ProtectSystem=strict
ProtectControlGroups=true
# Allow only on AddressFamily and then deny it to effectively deny everything
RestrictAddressFamilies=AF_AX25
RestrictAddressFamilies=~AF_AX25
RestrictNamespaces=true
SystemCallArchitectures=native
SystemCallErrorNumber=EPERM
SystemCallFilter=@system-service
SystemCallFilter=~@privileged
SystemCallFilter=~@resources
RemoveIPC=true
IPAddressDeny=any
RestrictSUIDSGID=true
RestrictRealtime=true
MemoryDenyWriteExecute=true
UMask=0077" | sudo tee /etc/systemd/system/kanata.service > /dev/null
sudo systemctl daemon-reload
