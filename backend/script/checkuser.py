from app import app, User

with app.app_context():
    users = User.query.all()

    if not users:
        print("No users found.")
    else:
        for u in users:
            print(f"ID={u.id} USERNAME={u.username}")