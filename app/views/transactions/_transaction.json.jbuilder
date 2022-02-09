json.extract! transaction, :id, :transaction_at, :notes, :amount, :transaction_type, :wallet_id, :category_id, :deleted_at, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
