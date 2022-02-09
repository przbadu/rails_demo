class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.monetize :amount
      t.datetime :transaction_at
      t.text :notes
      t.integer :transaction_type
      t.datetime :deleted_at

      t.belongs_to :wallet, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :transactions, :deleted_at
  end
end
