#Ubuntu 16.04 NIST 800-171 Public Script

#!/bin/bash
echo "Starting NIST-800-171 Script"
cp issue /etc/issue
sudo apt install -y libpam-pwquality
cp pwquality.conf /etc/security/pwquality.conf
echo "SHA_CRYPT_MIN_ROUNDS 5000" >> /etc/login.defs
sudo useradd -D -f 35
sudo apt install -y vlock
echo "* hard maxlogins 10" >> /etc/security/limits.conf
echo "auth required pam_tally.so onerr=fail deny=10" >> /etc/pam.d/common-auth
echo "auth required pam_faildelay.so delay=3000" >> /etc/pam.d/common-auth
echo "session required pam_lastlog.so showfailed" >> /etc/pam.d/login
sudo apt-get -y install aide
#check aide cron job and mail delivery
sudo echo "blacklist usb-storage" >> /etc/modprobe.d/blacklist.conf
sudo apt-get install libpam-apparmor
sudo systemctl enable apparmor.service
systemctl disable kdump.service
sudo apt install -y auditd
sudo systemctl enable auditd.service
sudo systemctl start auditd.service
echo "*.* @<your-syslog-server>:514" >> /etc/rsyslog.d/50-default.conf
sudo systemctl restart rsyslog
sudo apt-get remove telnetd nis rsh-server -y
sudo apt-get remove  -y
sudo apt-get remove  -y
sudo systemctl start ufw
sudo systemctl enable ufw
sudo apt-get install -y openssh-server
echo "banner=/etc/issue" >> /etc/ssh/sshd_config
echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" >> /etc/ssh/sshd_config
echo "MACs hmac-sha2-256,hmac-sha2-512" >> /etc/ssh/sshd_config
echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config
echo "PrintLastLog yes" >> /etc/ssh/sshd_config
echo "ClientAliveInterval 600" >> /etc/ssh/sshd_config
echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config
echo "IgnoreUserKnownHosts yes" >> /etc/ssh/sshd_config
echo "StrictModes yes" >> /etc/ssh/sshd_config
echo "Compression delayed" >> /etc/ssh/sshd_config
sudo /sbin/sysctl -w net.ipv4.tcp_syncookies=1
sudo systemctl restart sshd
sudo /sbin/sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
sudo /sbin/sysctl -w net.ipv4.conf.default.accept_redirects=0
sudo /sbin/sysctl -w net.ipv4.conf.all.accept_redirects=0
sudo /sbin/sysctl -w net.ipv4.conf.default.send_redirects=0
sudo /sbin/sysctl -w net.ipv4.conf.all.send_redirects=0
sudo /sbin/sysctl -w net.ipv4.ip_forward=0
sudo sysctl -w net.ipv4.conf.default.accept_source_route=0
sudo apt remove -y vsftpd tftpd-hpa 
sudo apt install -y opensc-pkcs11 libpam-pkcs11 libnss3-tools libssl-dev pam0g-dev pkg-config libpcsclite-dev libtool autoconf opensc pcsc-toolspcsc
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
cp audit.rules /etc/audit/audit.rules
chmod 640 /etc/audit/audit.rules
#echo "Installing Desktop Environment" Not relevant if already installed. Need to add modify to if already installed. 
#sudo apt-get install -y ubuntu-gnome-desktop 
#Set Login Banner For GNOME as well as removing user list and power options
cat gnome-changes.txt >> /etc/gdm3/greeter.dconf-defaults
sudo dconf update
sudo systemctl restart gdm
#SSSD installation
sudo apt install -qq krb5-user samba sssd sssd-tools realmd adcli chrony packagekit -y
#Automate creation of home directory
sed -i "30i session required    pam_mkhomedir.so skel=/etc/skel/ umask=0022" /etc/pam.d/common-session
sudo systemctl enable sssd
sudo sed -i "8i UsePAM yes" /etc/ssh/sshd_config
sudo systemctl restart sshd
exit
