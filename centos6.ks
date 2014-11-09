#############################################
# Kickstart for MNC 64bit (based from superlinuxer.ks)
#
# @file: mnc.ks
# @brief:
# @author: 
# @version: $Revision: 
# @date: $Date:

# http://docs.redhat.com/docs/ko-KR/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/ch-kickstart2.html
# http://www.redhat.com/promo/summit/2010/presentations/summit/decoding-the-code/wed/cshabazi-530-more/MORE-Kickstart-Tips-and-Tricks.pdf
# https://gist.github.com/ralexandru/3143249
# http://fedoraproject.org/wiki/Anaconda/Kickstart
text
skipx
install
reboot
lang en_US.UTF-8
keyboard us

#network --device eth0 --bootproto=static --ip=10.10.10.10 --netmask=10.10.10.255 --gateway=10.10.10.1 --nameserver=168.126.63.1
#network --bootproto=dhcp --device=eth0 --onboot=yes --noipv6 --hostname=mnc.com
network --bootproto=dhcp --device=eth0 --onboot=yes --noipv6 --hostname=test.itconsultant.kr
network --bootproto=dhcp --device=eth1 --onboot=yes --noipv6 

# Default Password: ser()ver1
rootpw --iscrypted $1$JOoFG3VJ$l2Xv2g9eCIIB6sTDDjcJZ/
firewall --disabled
selinux --disabled
authconfig --enableshadow --passalgo=sha512 --enablecache
timezone Asia/Seoul
bootloader --location=mbr
zerombr yes

#url --url http://ftp.daum.net/centos/6.3/os/x86_64/

# Specify a cost(10~) for the DVD(non-minimal cd)
#repo --name="CentOS" --mirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=os --cost=10
#repo --name="SuperLinuxer-base" --baseurl=http://rpms.superlinuxer.com/centos/6/base/x86_64/ --cost=20
#repo --name="SuperLinuxer-core" --baseurl=http://rpms.superlinuxer.com/centos/6/core/x86_64/ --cost=30
#repo --name="CentOS-Update" --mirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=updates --cost=40

#########################################
# Select disk
clearpart --all --initlabel
part / --fstype ext4 --size=1024 --grow --asprimary --ondisk sda
part swap --size=1024 --asprimary --ondisk sda

#########################################
# Set Software Raid - sda + sdb
#clearpart --all --initlabel
#part / --fstype ext4 --size=10240 --asprimary --ondisk sda
#part swap --size=1024 --asprimary --ondisk sda
#part raid.01 --size=1024 --grow --asprimary --ondisk sda
#part raid.02 --size=1024 --grow --asprimary --ondisk sdb
#raid /data --level=0 --device=md0 --fstype ext4 raid.01 raid.02

#########################################
# Auto select disk
#clearpart --all --initlabel
#part /brick1 --fstype xfs --size=10240 --asprimary
#part / --fstype ext4 --size=1024 --grow --asprimary
#part swap --size=1024 --asprimary

#########################################
# Select packages
%packages --nobase
@core
#superlinuxer-setup
#openssh-clients
#bind-utils
#bridge-utils
#irqbalance
#logrotate
#nscd
#ntp
#ntpdate
#ntsysv
#readahead
#sysstat
#tmpwatch
#vim-enhanced
#yum-cron
#man
%end

#########################################
# Run post script
%post --log=/tmp/centos6-post.log
/usr/bin/curl http://ks.itconsultant.kr/centos6_post.ks -o /tmp/postscript.sh
/bin/sh /tmp/postscript.sh

#superman setup bootstrap
