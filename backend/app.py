from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_cors import CORS
import os
import json

# ----------------- APP SETUP -----------------
app = Flask(__name__)

app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY", "dev-secret")
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///users.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
CORS(app)

# ----------------- PATHS -----------------
BASE_DIR = os.path.dirname(__file__)
DB_FOLDER = os.path.join(BASE_DIR, "../database")
EXERCISES_FILE = os.path.join(DB_FOLDER, "exercises.json")

os.makedirs(DB_FOLDER, exist_ok=True)

# ----------------- MODELS -----------------
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)

# ----------------- ROUTES -----------------
@app.route("/register", methods=["POST"])
def register():
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"error": "Username and password required"}), 400

    if User.query.filter_by(username=username).first():
        return jsonify({"error": "User already exists"}), 400

    hashed_password = generate_password_hash(password)
    user = User(username=username, password=hashed_password)

    db.session.add(user)
    db.session.commit()

    return jsonify({"message": "User registered"}), 201


@app.route("/login", methods=["POST"])
def login():
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"error": "Username and password required"}), 400

    user = User.query.filter_by(username=username).first()

    if user and check_password_hash(user.password, password):
        return jsonify({
            "session": "demo",
            "user_id": user.id
        }), 200

    return jsonify({"error": "Invalid credentials"}), 401


@app.route("/exercises", methods=["GET"])
def get_exercises():
    if not os.path.exists(EXERCISES_FILE):
        return jsonify([])

    try:
        with open(EXERCISES_FILE, "r") as f:
            data = json.load(f)
        return jsonify(data)
    except Exception:
        return jsonify({"error": "Failed to load exercises"}), 500


# ----------------- RUN -----------------
if __name__ == "__main__":
    with app.app_context():
        db.create_all()

    app.run(host="0.0.0.0", port=5000, debug=True)
