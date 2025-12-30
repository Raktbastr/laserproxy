#! /bin/bash

cd /opt/laserproxy || exit
source env/bin/activate
pip install -r requirements.txt
exec python3 laserproxy.py