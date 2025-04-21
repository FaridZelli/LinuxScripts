# 📚️ Linux Scripts
This repository contains my post-installation scripts for various Linux distributions.
   
ⓘ All scripts must be run as **root**.
   
## Fedora Workstation 42
   
### fedora_ws_base.sh
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.
   
  ```
  curl -o ~/fedora_ws_base.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/fedora_ws_base.sh && chmod a+x ~/fedora_ws_base.sh && ~/fedora_ws_base.sh ; rm -f ~/fedora_ws_base.sh
  ```
   
## openSUSE Tumbleweed
   
### tumbleweed_base.sh (not actively maintained)
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.
   
  ```
  curl -o ~/tumbleweed_base.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/tumbleweed_base.sh && chmod a+x ~/tumbleweed_base.sh && ~/tumbleweed_base.sh ; rm -f ~/tumbleweed_base.sh
  ```
   
# 💡 Tips & Tricks
Useful suggestions to improve your workflow.
   
## Personalize Bash
- Enable menu-complete:   
Make your terminal more efficient by enabling directory completion
```
grep -qF 'TAB: menu-complete' ~/.inputrc || echo 'TAB: menu-complete' >> ~/.inputrc
```
- Disable HISTFILE:   
If you prefer not to save your command history
```
grep -qF 'unset HISTFILE' ~/.bashrc || echo 'unset HISTFILE' >> ~/.bashrc
```
- Customize your prompt:   
[linrock/bash-prompt-generator](https://github.com/linrock/bash-prompt-generator)
```
echo 'export PS1="\[$(tput setaf 216)\]\u\[$(tput setaf 220)\]@\[$(tput setaf 222)\]\h \[$(tput setaf 229)\]\w \[$(tput sgr0)\]$ "' >> ~/.bashrc
```
## Flatpaks and AppImages
Suggested tools:
- [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal) - Flatpak permission manager
- [Gear Lever](https://flathub.org/apps/it.mijorus.gearlever) - AppImage helper
## Security Auditing
Suggested tools:
- [Lynis](https://github.com/CISOfy/lynis) - Security auditing tool for Linux
- [ssh-audit](https://github.com/jtesta/ssh-audit) - SSH server & client security auditing
