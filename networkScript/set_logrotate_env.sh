#!/bin/sh
# set up the logrotate environment to backup wan-chain log data

#   __        ___    _   _  ____ _           _       ____

#   \ \      / / \  | \ | |/ ___| |__   __ _(_)_ __ |  _ \  _____   __

#    \ \ /\ / / _ \ |  \| | |   | '_ \ / _` | | '_ \| | | |/ _ \ \ / /

#     \ V  V / ___ \| |\  | |___| | | | (_| | | | | | |_| |  __/\ V /

#      \_/\_/_/   \_\_| \_|\____|_| |_|\__,_|_|_| |_|____/ \___| \_/

#

#add wanchainlog logrotateconf 
mkdir -p $HOME/wanchainbackup/logbackup
wanchainLogPath=$HOME/wanchainbackup/logbackup/wanchainlog.txt
hotbackuplogPath=$HOME/wanchainbackup/hotbackup/log.txt
coldbackuplogPath=$HOME/wanchainbackup/coldbackup/log.txt
wanchainLogRotateConf=/etc/logrotate.d/wanchainlog
sudo touch $wanchainLogRotateConf
sudo chmod 777 $wanchainLogRotateConf
echo "
$hotbackuplogPath
$coldbackuplogPath
$wanchainLogPath
{
   daily
   dateext
   rotate 7
   delaycompress
   compress
   notifempty
   missingok
   copytruncate
}
" > $wanchainLogRotateConf
sudo chmod 644 $wanchainLogRotateConf

#add daily schedule to crontab
sudo chmod 777 /etc/crontab
echo "59 23 * * * root run-parts /etc/cron.daily" >> /etc/crontab
sudo chmod 644 /etc/crontab

