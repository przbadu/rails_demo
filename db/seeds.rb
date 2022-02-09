# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.first

if user.categories.count.zero?
  20.times do |i|
    color = format('%06x', (rand * 0xffffff))
    category = user.categories.create!(name: "Category #{i}", color: color)
    puts "Category #{category.name} added"
  end
end

if user.wallets.count.zero?
  %w[cash esewa bok ebl nbl].each do |i|
    balance = [1000, 30_000, 40_000, 2300].sample
    color = format('%06x', (rand * 0xffffff))
    wallet = user.wallets.create!(name: i, color: color, balance: balance)
    puts "Wallet #{wallet.name} added"
  end
end

if Transaction.count.zero?
  100.times do |_i|
    wallet = user.wallets.find(user.wallets.pluck(:id).sample)
    category = user.categories.find(user.categories.pluck(:id).sample)

    balance = [10, 300, 450, 23].sample
    kind = %i[income expense].sample
    date = [0, 2, 1, 4, 5, 6, 7, 8, 9, 10].sample.days.ago
    income = ['salary', 'freelancing', 'youtube', 'android app', 'ios app'].sample
    expense = %w[hotel foods drink travel books netflix].sample

    t = user.transactions.create(
      wallet: wallet,
      category: category,
      amount: balance,
      transaction_type: kind,
      transaction_at: date,
      notes: kind == 'income' ? "Income from #{income}" : "Expense done for #{expense}"
    )

    puts "Transaction #{t.id} added!"
  end
end
