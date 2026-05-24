from flask import Flask, jsonify
from flask_cors import CORS
from datetime import datetime
import random
import os
import time

app = Flask(__name__)
CORS(app)

LOG_FILE = "logs/recovery.log"
COUNT_FILE = "recovery_count.txt"

os.makedirs("logs", exist_ok=True)

if not os.path.exists(COUNT_FILE):
    with open(COUNT_FILE, "w") as f:
        f.write("0")

def write_log(message):
    with open(LOG_FILE, "a") as log:
        log.write(f"{datetime.now()} - {message}\n")

def get_recovery_count():
    with open(COUNT_FILE, "r") as f:
        return int(f.read())

# 🔥 LOG START (RECOVERY)
write_log("Container started / recovery")

@app.route("/")
def home():
    return jsonify({"message": "Backend running"})

@app.route("/health")
def health():
    return jsonify({
        "status": "Healthy",
        "time": str(datetime.now()),
        "recoveries": get_recovery_count(),
        "server_load": random.randint(20, 90)
    })

@app.route("/chaos")
def chaos():

    write_log("Chaos triggered")

    # Increase recovery count
    count = get_recovery_count()
    with open(COUNT_FILE, "w") as f:
        f.write(str(count + 1))

    time.sleep(1)

    # 🔥 FORCE CRASH
    os.system("kill -9 1")

    return "Chaos triggered"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)