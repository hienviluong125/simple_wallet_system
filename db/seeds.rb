# Users

admin = User.create(email: "admin@gmail.com", password: "12345678", role: "admin")
superadmin = User.create(email: "superadmin@gmail.com", password: "12345678", role: "superadmin")
user = User.create(email: "user@gmail.com", password: "12345678")

# Transaction
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 200)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 300)
user.transactions.create(transaction_type: "withdraw", status: "handled", amount: 100)
