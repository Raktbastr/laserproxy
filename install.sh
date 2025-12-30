#! /bin/bash

if [ "$(whoami)" != "root" ]; then
    echo Run as sudo!
    exit
fi

echo Please enter your Blue Alliance API key to be used
read -r key
echo "$key" >> key.txt
python3 -m venv env
mkdir /opt/laserproxy
cp ./key.txt /opt/laserproxy
cp ./requirements.txt /opt/laserproxy
cp ./laserproxy.py /opt/laserproxy
cp ./laserproxy.service /opt/laserproxy
cp ./laserproxy.sh /opt/laserproxy
cp -r ./env /opt/laserproxy
chown -R root /opt/laserproxy
chmod -R 755 /opt/laserproxy
ln -sf /opt/laserproxy/laserproxy.sh /usr/bin/
chown root /usr/bin/laserproxy.sh
chmod 755 /usr/bin/laserproxy.sh 
ln -sf /opt/laserproxy/laserproxy.service /etc/systemd/system/
chown root /etc/systemd/system/laserproxy.service
chmod 755 /etc/systemd/system/laserproxy.service
systemctl enable laserproxy
systemctl start laserproxy
echo All done!
echo To change the API key edit /opt/laserproxy/key.txt
