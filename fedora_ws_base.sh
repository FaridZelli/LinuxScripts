#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli
# Last updated 2024-6-6 7:31 PM

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
\033[33mWARNING: You do not seem to be logged in as root!\033[0m
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
    dnf config-manager --enable fedora-cisco-openh264
    dnf config-manager --enable rpmfusion-free
    dnf config-manager --enable rpmfusion-free-updates
    dnf config-manager --enable rpmfusion-nonfree
    dnf config-manager --enable rpmfusion-nonfree-updates
    # Installing codecs
    dnf swap ffmpeg-free ffmpeg --allowerasing
    dnf install libavcodec-freeworld gstreamer1-plugins-{base,good,good-extras,bad-freeworld,ugly} gstreamer1-plugin-{openh264,libav} --allowerasing
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

# Ask whether to enable hardware acceleration
echo -e "
\033[33mWould you like to enable hardware acceleration? (Recommended)\033[0m

1) Yes, install Intel media drivers (for Intel GPUs)
2) Yes, install Mesa VAAPI and VDPAU drivers (for AMD GPUs)
3) Yes, install NVIDIA VAAPI wrapper (for NVIDIA GPUs)
4) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Installing drivers
    dnf install intel-media-driver
    ;;
  2 ) 
    # Installing drivers
    dnf swap mesa-va-drivers mesa-va-drivers-freeworld
    dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    ;;
  3 ) 
    # Installing drivers
    dnf install libva-nvidia-driver
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
\033[33mWould you like to setup Flathub?\033[0m

1) Yes, add Flathub + Flathub Beta
2) Yes, only add Flathub
3) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Adding Flathub and Flathub Beta
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists flathub-beta https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo
    flatpak remote-modify --enable flathub
    flatpak remote-modify --enable flathub-beta
    ;;
  2 ) 
    # Adding Flathub
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
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
