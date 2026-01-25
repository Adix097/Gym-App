from app import app, load_users

with app.app_context():
    users = load_users()

    if not users:
        print("No users found.")
    else:
        for u in users:
            print(f"ID={u['id']} USERNAME={u['username']}")
