class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :owner_id, null: false

      t.timestamps
    end

    add_index :accounts, :name, unique: true
    add_foreign_key :accounts, :users, column: :owner_id
  end
end
