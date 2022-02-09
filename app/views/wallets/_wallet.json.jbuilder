json.extract! wallet, :id, :name, :icon, :color, :balance, :deleted_at, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
