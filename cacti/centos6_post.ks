#!/bin/sh

#############################################
# Post Script for cacti server 64bit 
#
# @file: centos6_post.ks
# @brief:
# @author: Jaehyun Kim (ses0sj@gmail.com)
# @version: $Revision: 
# @date: $Date: 09 Nov 14

echo "Start Post Script"

yum -y remove \*.i\?86 2>&1 ; sed -i -e '/exclude=\*\.i?86/d' /etc/yum.conf && echo 'exclude=*.i?86' >> /etc/yum.conf
sed -i -e '/^assumeyes=.*/d' /etc/yum.conf && echo 'assumeyes=0' >> /etc/yum.conf

yum clean all
yum install -y openssh-clients bind-utils bridge-utils irqbalance logrotate nscd ntp ntpdate ntsysv readahead sysstat tmpwatch vim-enhanced yum-cron man net-snmp net-snmp-utils nc wget tcpdump

sed -i -e 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux; sed -i -e 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config ; setenforce 0 2>&1

/usr/bin/curl http://ks.itconsultant.kr/bashrc -o /root/.bashrc

cat > /etc/yum.repos.d/MariaDB.repo <<EOM
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/5.5/centos6-amd64
gpgkey = https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck = 1
EOM

# install packages for cacti
yum install -y MariaDB-server MariaDB-client rrdtool php httpd php-mysql php-snmp git


# Install and Configure Cacti
git clone 'https://github.com/itconsultant/cacti.git' /var/www/html

# Confiure MySQL 
mysqladmin --user=root create cacti
mysql cacti < /var/www/html/cacti.sql
mysql --user=root mysql -e "GRANT ALL ON cacti.* TO cactiuser@localhost IDENTIFIED BY 'cacti()password1';flush privileges;"

#mysqladmin --user=root password 'mysql()server1'

