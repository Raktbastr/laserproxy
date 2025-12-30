import socket
import sys
from flask import Flask
import requests
from datetime import datetime

TEAM_URL = "https://www.thebluealliance.com/api/v3/team/frc$teamNumber$/events/$year$"
EVENT_URL = "https://www.thebluealliance.com/api/v3/event/$eventCode$/teams"
with open('key.txt', 'r') as f:
    API_KEY = f.read()
HEADERS = {'X-TBA-Auth-Key': API_KEY.strip()}

app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    return "hi"

@app.route('/teamsearch/<int:num>', methods=['GET'])
def team(num):
    u = TEAM_URL.replace('$teamNumber$', str(num))
    if datetime.now().month >= 9:
        u = u.replace('$year$', str((datetime.now().year)+1))
    else:
        u = u.replace('$year$', str(datetime.now().year))
    response = requests.get(u, headers=HEADERS)
    return response.json()

@app.route('/eventsearch/<string:code>', methods=['GET'])
def event(code):
    u = EVENT_URL.replace('$eventCode$', code)
    response = requests.get(u, headers=HEADERS)
    return response.json()

app.run(port=2077)