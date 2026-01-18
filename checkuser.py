from app import db, User, app

with app.app_context():
    users = User.query.all()
    for u in users:
        print("ID:", u.id, "Username:", u.username, "Password:", u.password)
