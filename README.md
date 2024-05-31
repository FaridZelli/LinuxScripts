# 📚️ Linux Scripts
This repository contains my installation and setup scripts for various Linux distributions.
   
**Note:** All scripts must be run as **root**.
   
## 🌐 Fedora Workstation
   
### fedora_ws_base.sh
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.
   
  ```
  curl -o ~/fedora_ws_base.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/fedora_ws_base.sh && chmod a+x ~/fedora_ws_base.sh && ~/fedora_ws_base.sh ; rm ~/fedora_ws_base.sh
  ```
   
### fedora_ws_rocm_radeon.sh
- Performs a lightweight **ROCm** installation for **Radeon GPUs**.
   
  ```
  curl -o ~/fedora_ws_rocm_radeon.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/fedora_ws_rocm_radeon.sh && chmod a+x ~/fedora_ws_rocm_radeon.sh && ~/fedora_ws_rocm_radeon.sh ; rm ~/fedora_ws_rocm_radeon.sh
  ```
   
## 🦎 openSUSE Tumbleweed
   
### tumbleweed_base.sh
- This script automates various maintenance tasks required after a fresh installation,   
  such as installing non-free drivers and codecs.   
- Also includes [zypper-unjammed](https://github.com/makesourcenotcode/zypper-unjammed) and sets up an alias for zypper-autoremove.
   
  ```
  curl -o ~/tumbleweed_base.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/tumbleweed_base.sh && chmod a+x ~/tumbleweed_base.sh && ~/tumbleweed_base.sh ; rm ~/tumbleweed_base.sh
  ```
   
### tumbleweed_rocm_radeon.sh
- Performs a lightweight **ROCm** installation for **Radeon GPUs**.
   
  ```
  curl -o ~/tumbleweed_rocm_radeon.sh https://raw.githubusercontent.com/FaridZelli/LinuxScripts/main/tumbleweed_rocm_radeon.sh && chmod a+x ~/tumbleweed_rocm_radeon.sh && ~/tumbleweed_rocm_radeon.sh ; rm ~/tumbleweed_rocm_radeon.sh
  ```
   
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
