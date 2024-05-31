#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli

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
This script will install and configure ROCm on your \033[36mFedora Workstation\033[0m system.
I am not responsible for any damage or data loss that may occur.

\033[33mDo you wish to continue? (Y/N/R)\033[0m
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  [Yy]* ) 
    # Proceed with the rest of the script
    ;;
  [Rr]* ) 
    # Proceed with the rest of the script
    echo "Removing ROCm..."
    dnf remove rocm-opencl rocm-opencl-devel rocminfo rocm-smi-lib rocm-opencl-icd-loader clinfo
    rm /etc/yum.repos.d/rocm.repo
    dnf clean all
    echo -e "
--------------------------------------------------
\033[32mROCm has been removed from your system.\033[0m
--------------------------------------------------"
    exit 1
    ;;
  * )
    # Stop the script for any other input
    echo "Stopping the script..."
    exit 1
    ;;
esac

tee --append /etc/yum.repos.d/rocm.repo <<EOF
[ROCm-latest]
name=ROCm
enabled=1
baseurl=https://repo.radeon.com/rocm/yum/latest/main
priority=90
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOF

dnf config-manager --add-repo /etc/yum.repos.d/rocm.repo
dnf clean all
dnf install rocm-opencl rocm-opencl-devel rocminfo rocm-smi-lib rocm-opencl-icd-loader clinfo

# End of script
echo -e "
--------------------------------------------------

\033[32mIt's time to reboot!\033[0m
\033[32mRemember to enable ROCm for non-root users by running:\033[0m

usermod -a -G render,video \033[33mUSERNAME\033[0m

--------------------------------------------------"
