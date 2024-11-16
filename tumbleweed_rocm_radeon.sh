#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli
# Last updated 2024-11-17 2:50 AM

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
This script will install and configure ROCm OpenCL 6.2.3 on your \033[32mopenSUSE Tumbleweed\033[0m system.
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
    zypper remove -u rocm-opencl rocm-opencl-devel rocm-opencl-icd-loader rocm-smi-lib rocminfo
    zypper removerepo rocm
    zypper removerepo amdgpu
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

rm -f /etc/zypp/repos.d/rocm.repo
rm -f /etc/zypp/repos.d/amdgpu.repo

tee --append /etc/zypp/repos.d/rocm.repo <<EOF
[rocm]
name=ROCm 6.2.3
enabled=1
autorefresh=1
baseurl=https://repo.radeon.com/amdgpu/6.2.3/sle/15.6/main/x86_64/
priority=50
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOF

tee --append /etc/zypp/repos.d/amdgpu.repo <<EOF
[amdgpu]
name=AMDGPU 6.2.3
enabled=1
autorefresh=1
baseurl=https://repo.radeon.com/rocm/zyp/6.2.3/main
priority=50
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOF

zypper refresh
zypper --gpg-auto-import-keys install rocm-opencl rocm-opencl-devel rocm-opencl-icd-loader rocm-smi-lib rocminfo clinfo

# End of script
echo -e "
--------------------------------------------------

\033[32mIt's time to reboot!\033[0m
\033[32mRemember to enable ROCm for non-root users by running:\033[0m

usermod -a -G render,video \033[33mUSERNAME\033[0m

--------------------------------------------------"
