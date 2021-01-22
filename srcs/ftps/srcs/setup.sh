#!/bin/sh

adduser aduchemi
echo "aduchemi:password1!" | chpasswd

mkdir /home/aduchemi/ftp
chown nobody:nogroup /home/aduchemi/ftp
chmod a-w /home/aduchemi/ftp
mkdir /home/aduchemi/ftp/files
cd /home/aduchemi/ftp/files
echo "test file" | tee /home/aduchemi/ftp/files/tes.txt
chown aduchemi:aduchemi /home/aduchemi/ftp/files
echo "aduchemi" | tee -a /etc/vsftpd.userlist

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log &
telegraf &
vsftpd /etc/vsftpd/vsftpd.conf
