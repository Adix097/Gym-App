from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_cors import CORS
import json
import os

# ----------------- APP SETUP -----------------
app = Flask(__name__)
app.config['SECRET_KEY'] = 'gym-secret-key'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
CORS(app)

# Path to database folder
DB_FOLDER = os.path.join(os.path.dirname(__file__), "../database")
EXERCISES_FILE = os.path.join(DB_FOLDER, "exercises.json")

# Ensure database folder exists
os.makedirs(DB_FOLDER, exist_ok=True)

# ----------------- USER MODEL -----------------
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)

# ----------------- ROUTES -----------------
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"error": "Username and password required"}), 400

    if User.query.filter_by(username=username).first():
        return jsonify({"error": "User already exists"}), 400

    hashed_password = generate_password_hash(password, method='pbkdf2:sha256')
    new_user = User(username=username, password=hashed_password)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered"}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"error": "Username and password required"}), 400

    user = User.query.filter_by(username=username).first()
    if user and check_password_hash(user.password, password):
        return jsonify({"token": "fake-jwt-token", "id": user.id}), 200
    return jsonify({"error": "Invalid credentials"}), 401

@app.route("/exercises", methods=["GET"])
def get_exercises():
    # Read from exercises.json
    with open(EXERCISES_FILE, "r") as f:
        exercises = json.load(f)
    return jsonify(exercises)

# ----------------- RUN APP -----------------
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(host="0.0.0.0", debug=True)
