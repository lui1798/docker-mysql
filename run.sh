#!/bin/bash
set -e

source /etc/profile
#查看mysql服务的状态
echo `service mysql status`
#启动mysql
#systemctl start mysql
service mysql start
sleep 3
echo `systemctl status mysql`

mysql -e "grant all privileges on *.* to ${MYSQL_USER}@'${MYSQL_HOST}' identified by '${MYSQL_PASSWORD}' ;flush privileges;

while true;do
    curday=`date '+%Y-%m-%d %H:%M:%S'`
    conn=`mysqladmin -uroot status 2>/dev/nul |awk '{print $4}'`
    [ -z $conn ] && conn=0
    log=`echo $curday "Number of active DB connections is" $conn`
    echo $log >/data/log
    sleep 30
done