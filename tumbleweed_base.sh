#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli
# Last updated 2024-7-25 3:19 PM

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
This script will reconfigure your \033[32mopenSUSE Tumbleweed\033[0m environment.
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
\033[33mWould you like to install multimedia codecs from Packman? (Recommended)\033[0m

1) Yes, install proprietary codecs
2) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
  # Adding packman-essentials repository
  zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/' packman-essentials
  zypper dup --from packman-essentials --allow-vendor-change
  # Installing codecs
  zypper in alsa alsa-oss alsa-plugins pipewire pipewire-alsa pipewire-pulseaudio pipewire-jack pipewire-aptx wireplumber wireplumber-audio ffmpeg libavcodec-full gstreamer-plugin-{openh264,pipewire} gstreamer-plugins-{base,good,good-extra,bad,ugly,libav} gstreamer-plugins-{bad,ugly}-codecs
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

# Ask whether to install Flatpak
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
    zypper in flatpak
    # Adding Flathub
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-modify --enable flathub
    ;;
  2 ) 
    # Installing Flatpak
    zypper in flatpak
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

# Ask whether to remove web browsers
echo -e "
\033[33mWould you like to remove all web browsers? (for Flatpak users)\033[0m

1) Yes, remove and lock all browsers
2) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Removing web_browser providers (zypper se --provides web_browser)
    zypper rm -n -u chromium elinks falkon links lynx MozillaFirefox seamonkey ungoogled-chromium w3m
    zypper al chromium elinks falkon links lynx MozillaFirefox seamonkey ungoogled-chromium w3m
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

# Ask whether to install zypper-unjammed
echo -e "
\033[33mWould you like to install zypper-unjammed?\033[0m

1) Yes, add to home directory and create alias for "zypper-autoremove"
2) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Adding zypper-unjammed to home directory
    # https://github.com/makesourcenotcode/zypper-unjammed
    curl -o /root/.zypper-unjammed https://raw.githubusercontent.com/makesourcenotcode/zypper-unjammed/main/zypper-unjammed
    chmod +x /root/.zypper-unjammed
    # Creating alias
    grep -qF 'alias zypper-unjammed="/root/.zypper-unjammed"' /root/.bashrc || echo 'alias zypper-unjammed="/root/.zypper-unjammed"' >> /root/.bashrc
    grep -qF 'alias zypper-autoremove="/root/.zypper-unjammed autoremove"' /root/.bashrc || echo 'alias zypper-autoremove="/root/.zypper-unjammed autoremove"' >> /root/.bashrc
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
