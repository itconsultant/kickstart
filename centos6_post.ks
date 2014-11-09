#!/bin/sh

#############################################
# Post Script for MNC 64bit 
#
# @file: mnc.ps
# @brief:
# @author: 
# @version: $Revision: 
# @date: $Date:

echo "Start Post Script"

# Remove 32bit Package
yum -y remove \*.i\?86 2>&1 ; sed -i -e '/exclude=\*\.i?86/d' /etc/yum.conf && echo 'exclude=*.i?86' >> /etc/yum.conf
sed -i -e '/^assumeyes=.*/d' /etc/yum.conf && echo 'assumeyes=0' >> /etc/yum.conf

# Update All of Packages (remove for test)
yum clean all
#yum update -y
yum install -y openssh-clients bind-utils bridge-utils irqbalance logrotate nscd ntp ntpdate ntsysv readahead sysstat tmpwatch vim-enhanced yum-cron man net-snmp net-snmp-utils nc wget tcpdump

# Turn Off Firewall (IPTalbles)
sed -i -e 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux; sed -i -e 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config ; setenforce 0 2>&1

## Install Superlinuxer Release
#rpm -Uvh "http://rpms.superlinuxer.com/centos/6/core/x86_64/RPMS/superlinuxer-release-6-1.el6.splr.noarch.rpm"
#yum install superlinuxer-setup -y
#superman setup bootstrap
## Disable SuperLinuxer.repo because it is unstable
#sed -i -e 's/enabled=1/enabled=0/g' /etc/yum.repos.d/SuperLinuxer.repo


## Install CFEngine


## Install Varnish
#rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el6/noarch/varnish-release/varnish-release-3.0-1.el6.noarch.rpm
#yum install -y varnish
#chkconfig --level 345 varnish on
#/etc/init.d/varnish start

## Install MariaDB
## Yum Repository 
cat > /etc/yum.repos.d/MariaDB.repo <<EOM
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/5.5/centos6-amd64
gpgkey = https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck = 1
EOM

## MariaDB Install
yum install -y MariaDB-server MariaDB-client

## Install Percona xtraBackup
## Yum Repository 
cat > /etc/yum.repos.d/Percona.repo <<EOM
[percona]
name = CentOS $releasever - Percona
baseurl = http://repo.percona.com/centos/$releasever/os/$basearch/
enabled = 1
gpgkey = http://www.percona.com/downloads/RPM-GPG-KEY-percona
gpgcheck = 1
EOM

## MariaDB Install
yum install -y percona-xtrabackup nc

/usr/bin/curl http://ks.itconsultant.kr/bashrc -o /root/.bashrc
