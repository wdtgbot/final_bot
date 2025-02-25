#!/bin/bash


touch /root/.aria2/aria2.session
chmod 0777 /root/.aria2/ -R


nohup filebrowser -r /  -p 9184 >> /dev/null 2>&1 & 

mkdir /.config/
mkdir /.config/rclone
touch /.config/rclone/rclone.conf
echo "$Rclone" >>/.config/rclone/rclone.conf
wget git.io/tracker.sh
chmod 0777 /tracker.sh
/bin/bash tracker.sh "/root/.aria2/aria2.conf"


rm -rf /bot
git clone https://${git_token}:x-oauth-basic@github.com/666wcy/new_bot.git   >> /dev/null 2>&1
mkdir /bot/
mv /new_bot/bot/* /bot/

rm /etc/nginx/nginx.conf
cp /new_bot/root/nginx.conf /etc/nginx/


chmod 0777 /bot/ -R
rm -rf /new_bot
python3 /bot/nginx.py
nginx -c /etc/nginx/nginx.conf
nginx -s reload

nohup aria2c --conf-path=/root/.aria2/aria2.conf --rpc-listen-port=8080 --rpc-secret=$Aria2_secret &

#nohup python3 /bot/web.py &
export RCLONE_CONFIG=/.config/rclone/rclone.conf

nohup rclone rcd --rc-addr=127.0.0.1:5572 --rc-user=root --rc-pass=$Aria2_secret --rc-allow-origin="https://elonh.github.io" &
python3 /bot/main.py
