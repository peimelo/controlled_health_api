class AddNameIndexInAccounts < ActiveRecord::Migration[6.1]
  def change
    add_index :accounts, %i[name owner_id], unique: true
  end
end
