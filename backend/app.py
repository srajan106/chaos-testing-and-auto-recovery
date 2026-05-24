from flask import Flask, jsonify
from flask_cors import CORS
from datetime import datetime
import random
import os
import logging

app = Flask(__name__)
CORS(app)

# Files
RECOVERY_FILE = "recovery_count.txt"
FLAG_FILE = "recover.flag"

# Logging setup
logging.basicConfig(
    filename="logs/app.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# Ensure required directories/files exist
os.makedirs("logs", exist_ok=True)

if not os.path.exists(RECOVERY_FILE):
    with open(RECOVERY_FILE, "w") as f:
        f.write("0")

# Detect recovery after crash
if os.path.exists(FLAG_FILE):
    try:
        with open(RECOVERY_FILE, "r") as f:
            count = int(f.read())

        with open(RECOVERY_FILE, "w") as f:
            f.write(str(count + 1))

        os.remove(FLAG_FILE)
        logging.info("Recovery detected. Incremented recovery count.")

    except Exception as e:
        logging.error(f"Error during recovery handling: {e}")


def get_count():
    try:
        with open(RECOVERY_FILE, "r") as f:
            return int(f.read())
    except:
        return 0


@app.route("/")
def home():
    logging.info("Home endpoint accessed")
    return jsonify({
        "message": "Backend running"
    })


@app.route("/health")
def health():
    load = random.randint(20, 95)

    status = "Healthy"
    if load > 85:
        status = "High Load"

    logging.info(f"Health checked: load={load}, status={status}")

    return jsonify({
        "status": status,
        "time": str(datetime.now()),
        "recoveries": get_count(),
        "server_load": load
    })


# 🔥 Chaos endpoint (simulate failure)
@app.route("/chaos")
def chaos():
    logging.warning("Chaos endpoint triggered! Simulating crash...")

    # create flag file so recovery script detects crash
    with open(FLAG_FILE, "w") as f:
        f.write("crashed")

    # force crash
    os._exit(1)


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000
    )