# 📚️ Linux Scripts
This repository contains my post-installation scripts for various Linux distributions.

> [!IMPORTANT]
> All scripts must be run as **root**.  
> Use `sudo su root` or `su root` before running these commands.
   
## Fedora Workstation / KDE 44
   
### [fedora_ws_base.sh](/fedora_ws_base.sh)
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.
- Please ensure your system is up-to-date before running the script.
```
dnf clean all && dnf distro-sync --refresh && reboot
```
   
```
curl -o ~/fedora_ws_base.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/fedora_ws_base.sh && chmod a+x ~/fedora_ws_base.sh && ~/fedora_ws_base.sh ; rm -f ~/fedora_ws_base.sh
```
   
## openSUSE Tumbleweed
   
### [tumbleweed_base.sh](/tumbleweed_base.sh) (unmaintained)
<details><summary>Show</summary>

<br>
   
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.
- Please ensure your system is up-to-date before running the script.
```
zypper clean && zypper refresh && zypper dup && reboot
```
   
```
curl -o ~/tumbleweed_base.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/tumbleweed_base.sh && chmod a+x ~/tumbleweed_base.sh && ~/tumbleweed_base.sh ; rm -f ~/tumbleweed_base.sh
```

</details>
   
# 💡 Tips & Tricks
These are my personal notes for a fresh Fedora Workstation / KDE install.
   
## Personalize Bash
- Enable menu-complete:   
Make it easier to navigate directories in the terminal by enabling tab completion.
```
grep -qF 'TAB: menu-complete' ~/.inputrc || echo 'TAB: menu-complete' >> ~/.inputrc
```
- Disable HISTFILE:   
If you prefer not to save your command history.
```
grep -qF 'unset HISTFILE' ~/.bashrc || echo 'unset HISTFILE' >> ~/.bashrc
```
- Customize your prompt:   
[linrock/bash-prompt-generator](https://github.com/linrock/bash-prompt-generator)
```
echo 'export PS1="\[$(tput setaf 216)\]\u\[$(tput setaf 220)\]@\[$(tput setaf 222)\]\h \[$(tput setaf 229)\]\w \[$(tput sgr0)\]$ "' >> ~/.bashrc
```
## Shutdown system on LUKS passphrase prompt timeout
To have your system shutdown when the LUKS passphrase hasn't been entered for some time:
  
Use `grubby` to add the following kernel command-line options to your boot entries.
```
grubby --update-kernel=ALL --args="rd.emergency=poweroff rd.shell=0"
```
Then specify a `timeout=` for your bootdrive in `/etc/crypttab` as follows.
```
nano /etc/crypttab
```
> For example:  
> `luks-xxxxxxxx UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx none x-initrd.attach,timeout=300`

And lastly, regenerate the `initramfs`.
```
dracut --regenerate-all --force
```
## Disable ambient light sensor in GNOME
For laptops that do not offer an option to disable the ambient light sensor through the UEFI:
```
mkdir -p /etc/dconf/db/{local,gdm}.d && printf '[org/gnome/settings-daemon/plugins/power]\nambient-enabled=false\n' | tee /etc/dconf/db/{local,gdm}.d/01-disable-ambient-light-sensor.conf >/dev/null && dconf update
```
## Use proper KDE theme for Qt apps in GNOME
If Qt apps are displayed incorrectly (e.g. missing icons), add the `QT_QPA_PLATFORMTHEME=kde` environment variable.

You can also increase the scaling factor of Qt apps with `QT_SCALE_FACTOR`:
```
flatpak override --user --env=QT_QPA_PLATFORMTHEME=kde --env=QT_SCALE_FACTOR=1.25
```
## Flatpaks and AppImages
Suggested tools:
- [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal) - Flatpak permission manager
- [Gear Lever](https://flathub.org/apps/it.mijorus.gearlever) - AppImage helper
## Security Auditing
Suggested tools:
- [Lynis](https://github.com/CISOfy/lynis) - Security auditing tool for Linux
- [ssh-audit](https://github.com/jtesta/ssh-audit) - SSH server & client security auditing
