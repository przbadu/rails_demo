class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :name
      t.string :icon
      t.string :color
      t.monetize :balance
      t.datetime :deleted_at
      t.belongs_to :user

      t.timestamps
    end
    add_index :wallets, :deleted_at
  end
end
