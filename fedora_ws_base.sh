#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli
# Last updated 2024-11-15 7:37 PM

# Check the current user
USER=$(whoami)
if [ "$USER" == "root" ]; then
  # Welcome text
  echo -e "
--------------------------------------------------
\033[32mYou are logged in as root.\033[0m
--------------------------------------------------"
else
  # Non-root user detected
  echo -e "
--------------------------------------------------
\033[31mWARNING: You do not seem to be logged in as root!\033[0m
--------------------------------------------------"
fi

# Ask whether to proceed
echo -e "
This script will reconfigure your \033[36mFedora Workstation\033[0m environment.
I am not responsible for any damage or data loss that may occur.

\033[33mDo you wish to continue? (Y/N)\033[0m
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  [Yy]* ) 
    # Proceed with the rest of the script
    ;;
  * )
    # Stop the script for any other input
    echo "Stopping the script..."
    exit 1
    ;;
esac

# Ask whether to install codecs
echo -e "
\033[33mWould you like to install multimedia codecs from RPM Fusion? (Recommended)\033[0m

1) Yes, install proprietary codecs
2) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Adding RPM Fusion repository
    dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    dnf config-manager setopt fedora-cisco-openh264.enabled=1
    dnf config-manager setopt rpmfusion-free.enabled=1
    dnf config-manager setopt rpmfusion-free-updates.enabled=1
    dnf config-manager setopt rpmfusion-nonfree.enabled=1
    dnf config-manager setopt rpmfusion-nonfree-updates.enabled=1
    # Installing codecs
    dnf swap ffmpeg-free ffmpeg --allowerasing
    dnf install pipewire-codec-aptx libavcodec-freeworld gstreamer1-plugins-{base,good,good-extras,bad-freeworld,ugly} gstreamer1-plugin-{openh264,libav} --allowerasing
    dnf upgrade @multimedia --allowerasing
    ;;
  2 ) 
    # Proceed with the rest of the script
    echo "Skipping..."
    ;;
  0 ) 
    # Exit the script
    echo "Stopping the script..."
    exit 1
    ;;
  * )
    # Stop the script for any other input
    echo "Invalid input, stopping the script..."
    exit 1
    ;;
esac

# Ask whether to setup hardware acceleration
echo -e "
\033[33mWould you like to setup hardware video acceleration? (Recommended)\033[0m

1) Yes, install everything for Intel and AMD GPUs
2) Yes, install Intel Media Driver and Intel Compute Runtime (for Intel GPUs)
3) Yes, install Mesa VAAPI and VDPAU drivers (for AMD GPUs)
4) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Installing drivers
    dnf install intel-media-driver intel-compute-runtime
    dnf swap mesa-va-drivers mesa-va-drivers-freeworld
    dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    ;;
  2 ) 
    # Installing drivers
    dnf install intel-media-driver intel-compute-runtime
    ;;
  3 ) 
    # Installing drivers
    dnf swap mesa-va-drivers mesa-va-drivers-freeworld
    dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    ;;
  4 ) 
    # Proceed with the rest of the script
    echo "Skipping..."
    ;;
  0 ) 
    # Exit the script
    echo "Stopping the script..."
    exit 1
    ;;
  * )
    # Stop the script for any other input
    echo "Invalid input, stopping the script..."
    exit 1
    ;;
esac

# Ask whether to setup Flathub
echo -e "
\033[33mWould you like to install Flatpak and setup Flathub?\033[0m

1) Yes, install Flatpak and only add Flathub
2) Yes, install Flatpak and add Flathub + Flathub Beta
3) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Installing Flatpak
    dnf install flatpak
    # Adding Flathub
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-modify --enable flathub
    ;;
  2 ) 
    # Installing Flatpak
    dnf install flatpak
    # Adding Flathub and Flathub Beta
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists flathub-beta https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo
    flatpak remote-modify --enable flathub
    flatpak remote-modify --enable flathub-beta
    ;;
  3 ) 
    # Proceed with the rest of the script
    echo "Skipping..."
    ;;
  0 ) 
    # Exit the script
    echo "Stopping the script..."
    exit 1
    ;;
  * )
    # Stop the script for any other input
    echo "Invalid input, stopping the script..."
    exit 1
    ;;
esac

# Ask whether to install remove-retired-packages
echo -e "
\033[33mWould you like to install remove-retired-packages?\033[0m

1) Yes, install remove-retired-packages
2) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Installing remove-retired-packages
    dnf install remove-retired-packages
    ;;
  2 ) 
    # Proceed with the rest of the script
    echo "Skipping..."
    ;;
  0 ) 
    # Exit the script
    echo "Stopping the script..."
    exit 1
    ;;
  * )
    # Stop the script for any other input
    echo "Invalid input, stopping the script..."
    exit 1
    ;;
esac

# End of script
echo -e "
--------------------------------------------------
\033[32mIt's time to reboot!\033[0m
--------------------------------------------------"
