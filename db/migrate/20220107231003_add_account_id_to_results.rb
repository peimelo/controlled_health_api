class AddAccountIdToResults < ActiveRecord::Migration[6.1]
  def up
    add_reference :results, :account, null: true, foreign_key: true

    Result.all.each do |result|
      result.account_id = result.user_id
      result.save
    end

    change_column_null :results, :account_id, false
    remove_reference :results, :user, foreign_key: true
  end

  def down
    add_reference :results, :user, null: true, foreign_key: true

    Result.all.each do |result|
      result.user_id = result.account_id
      result.save
    end

    change_column_null :results, :user_id, false
    remove_reference :results, :account, foreign_key: true
  end
end
