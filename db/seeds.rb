# Users

admin = User.create(email: "admin@gmail.com", password: "12345678", role: "admin")
superadmin = User.create(email: "superadmin@gmail.com", password: "12345678", role: "superadmin")
user = User.create(email: "user@gmail.com", password: "12345678")

# # Transaction
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 200)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 300)
user.transactions.create(transaction_type: "withdraw", status: "handled", amount: 100)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "deposit", status: "handled", amount: 10)
user.transactions.create(transaction_type: "withdraw", status: "handled", amount: 25)
user.transactions.create(transaction_type: "withdraw", status: "handled", amount: 35)
user.transactions.create(transaction_type: "withdraw", status: "handled", amount: 80)


10.times do |i|
  User.create(email: "user-#{i+1}@gmail.com", password: "12345678")
end
