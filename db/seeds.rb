user = User.first

# Categories
categories = [
  { icon: 'home', name: 'Housing Rent', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'car', name: 'Transportation & Car Insurance', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'airplane', name: 'Travel Expense', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'food-fork-drink', name: 'Food & Groceries', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'netflix', name: 'Utility Bills', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'cellphone', name: 'Cell Phone', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'school', name: 'Education', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'paw', name: 'Pet Food & Care', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'shopping', name: 'Clothing & Personal', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'stethoscope', name: 'Health & Insurance', color: format('%06x', (rand * 0xffffff)) },
  { icon: 'credit-card-outline', name: 'Monthly Subscriptions & Memberships',
    color: format('%06x', (rand * 0xffffff)) },
  { icon: 'television', name: 'Entertainment', color: format('%06x', (rand * 0xffffff)) }
]

user.categories.create(categories) unless user.categories.any?
puts "#{categories.count} Categories created!"

# Wallets
wallets = [
  { icon: 'cash', name: 'Cash', color: format('%06x', (rand * 0xffffff)), balance: 100 },
  { icon: 'wallet', name: 'eSewa', color: format('%06x', (rand * 0xffffff)), balance: 50 },
  { icon: 'bank', name: 'Bank', color: format('%06x', (rand * 0xffffff)), balance: 20_000 },
  { icon: 'credit-card', name: 'Credit Card', color: format('%06x', (rand * 0xffffff)), balance: 0 }
]
user.wallets.create(wallets) unless user.wallets.any?
puts "#{wallets.count} Wallets created!"

if Transaction.count.zero?
  100.times do |_i|
    wallet = user.wallets.find(user.wallets.pluck(:id).sample)
    category = user.categories.find(user.categories.pluck(:id).sample)

    balance = [10, 300, 450, 23].sample
    kind = %i[income expense].sample
    date = [0, 20, 100, 10, 40, 60, 30, 4, 5, 6, 7, 8, 9, 10].sample.days.ago

    t = user.transactions.create(
      wallet: wallet,
      category: category,
      amount: balance,
      transaction_type: kind,
      transaction_at: date,
      notes: kind == 'income' ? "Deposited to #{wallet.name}" : "Expense for #{category.name.humanize}"
    )

    puts "Transaction #{t.id} added!"
  end
end
