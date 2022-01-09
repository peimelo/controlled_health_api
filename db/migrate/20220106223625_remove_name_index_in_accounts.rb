class RemoveNameIndexInAccounts < ActiveRecord::Migration[6.1]
  def change
    remove_index :accounts, column: :name
  end
end
