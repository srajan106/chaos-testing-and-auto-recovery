from flask import Flask, jsonify
from flask_cors import CORS
from datetime import datetime
import random

app = Flask(__name__)
CORS(app)

@app.route("/")
def home():
    return jsonify({
        "message":"Backend running"
    })

@app.route("/health")
def health():
    return jsonify({
        "status":"Healthy",
        "time":str(datetime.now()),
        "recoveries":0,
        "server_load":random.randint(20,90)
    })

if __name__=="__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=False
    )