class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :icon
      t.string :color
      t.datetime :deleted_at
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :categories, :deleted_at
  end
end
