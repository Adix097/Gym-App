from flask import Flask, request, jsonify
from flask_cors import CORS
import json
import os
import uuid
import hashlib

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATABASE_DIR = os.path.join(BASE_DIR, "database")
USERS_FILE = os.path.join(DATABASE_DIR, "users.json")

app = Flask(__name__)
CORS(app)

# ---------- helpers ----------

def load_users():
    if not os.path.exists(USERS_FILE):
        return []
    with open(USERS_FILE, "r") as f:
        return json.load(f)

def save_users(users):
    os.makedirs(DATABASE_DIR, exist_ok=True)
    with open(USERS_FILE, "w") as f:
        json.dump(users, f, indent=2)

def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

# ---------- routes ----------

@app.route("/register", methods=["POST"])
def register():
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"error": "Username and password required"}), 400

    users = load_users()

    if any(u["username"] == username for u in users):
        return jsonify({"error": "User already exists"}), 400

    user = {
        "id": str(uuid.uuid4()),
        "username": username,
        "password": hash_password(password)
    }

    users.append(user)
    save_users(users)

    return jsonify({"message": "Registered"}), 201


@app.route("/login", methods=["POST"])
def login():
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    username = data.get("username")
    password = data.get("password")

    users = load_users()
    hashed = hash_password(password)

    for u in users:
        if u["username"] == username and u["password"] == hashed:
            return jsonify({
                "logged_in": True,
                "user_id": u["id"],
                "username": u["username"]
            }), 200

    return jsonify({"error": "Invalid credentials"}), 401


@app.route("/me", methods=["POST"])
def me():
    data = request.get_json(silent=True)
    user_id = data.get("user_id")

    users = load_users()
    for u in users:
        if u["id"] == user_id:
            return jsonify({
                "logged_in": True,
                "username": u["username"]
            })

    return jsonify({"logged_in": False}), 401


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=True)
