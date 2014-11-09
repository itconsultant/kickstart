#############################################
# Kickstart for cacti server 64bit
#
# @file: centos6.ks
# @brief:
# @author: Jaehyun Kim (ses0sj@gmail.com)
# @version: $Revision: 
# @date: $Date: 09 Nov 14 

text
skipx
install
reboot
lang en_US.UTF-8
keyboard us

network --bootproto=dhcp --device=eth0 --onboot=yes --noipv6 --hostname=cacti.itconsultant.kr
network --bootproto=dhcp --device=eth1 --onboot=yes --noipv6 

# Default Password: ser()ver1
rootpw --iscrypted $1$JOoFG3VJ$l2Xv2g9eCIIB6sTDDjcJZ/
firewall --disabled
selinux --disabled
authconfig --enableshadow --passalgo=sha512 --enablecache
timezone Asia/Seoul
bootloader --location=mbr
zerombr yes

clearpart --all --initlabel
part / --fstype ext4 --size=1024 --grow --asprimary --ondisk sda
part swap --size=1024 --asprimary --ondisk sda

%packages --nobase
@core
%end

%post --log=/tmp/centos6-post.log
/usr/bin/curl http://ks.itconsultant.kr/cacti/centos6_post.ks -o /tmp/postscript.sh
/bin/sh /tmp/postscript.sh

