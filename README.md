# 📚️ Linux Scripts
This repository contains my installation and setup scripts for various Linux distributions.
   
**Note:** All scripts must be run as **root**.
   
## 🦎 openSUSE Tumbleweed
   
### tumbleweed_base.sh
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.   
- Also includes [zypper-unjammed](https://github.com/makesourcenotcode/zypper-unjammed) and sets up an alias for zypper-autoremove.
   
### tumbleweed_rocm_radeon.sh
- Performs a lightweight **ROCm** installation for **Radeon GPUs**.
   
## 🌐 Fedora Workstation
   
### fedora_ws_base.sh
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.
   
### fedora_ws_rocm_radeon.sh
- Performs a lightweight **ROCm** installation for **Radeon GPUs**.
   
# 💡 Tips & Tricks
Useful information and suggestions that may improve your workflow.
   
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
- Customize your prompt [(linrock/bash-prompt-generator)](https://github.com/linrock/bash-prompt-generator)
```
echo 'export PS1="\[$(tput setaf 216)\]\u\[$(tput setaf 220)\]@\[$(tput setaf 222)\]\h \[$(tput setaf 229)\]\w \[$(tput sgr0)\]$ "' >> ~/.bashrc
```
## About Browsers
There are security and usability advantages to installing web browsers via Flatpak.   
I strongly recommend [Firefox](https://flathub.org/apps/org.mozilla.firefox) for daily use:
```
flatpak install flathub org.mozilla.firefox
```
## Flatpaks and AppImages
Suggested tools:
- [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal) - Flatpak permission manager
- [Gear Lever](https://flathub.org/apps/it.mijorus.gearlever) - AppImage helper
