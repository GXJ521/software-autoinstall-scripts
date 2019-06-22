#!/bin/bash
#*****************************************************************************************
# Filename: openssh_upgrade_7.9.p1.sh
# Create by: mrlapulga@126.com
# Create Data: 2019-04-24
# Usage: sh openssh_upgrade_7.9.p1.sh
# Version: v1.0
#*****************************************************************************************

cd openssh_rpm/
sudo rpm -Uvh *.rpm

sudo chmod 600 /etc/ssh/ssh_host_*_key
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.old
sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i "s/#UsePAM no/UsePAM yes/g" /etc/ssh/sshd_config
sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config

sudo cp /etc/pam.d/sshd /etc/pam.d/sshd.old
sudo cat > /etc/pam.d/sshd <<EOF
#%PAM-1.0 
auth required pam_sepermit.so 
auth include password-auth 
account required pam_nologin.so 
account include password-auth 
password include password-auth 
# pam_selinux.so close should be the first session rule 
session required pam_selinux.so close 
session required pam_loginuid.so 
# pam_selinux.so open should only be followed by sessions to be executed in the user context 
session required pam_selinux.so open env_params 
session optional pam_keyinit.so force revoke 
session include password-auth
EOF

sudo systemctl restart sshd
