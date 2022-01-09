class AddAccountIdToHeights < ActiveRecord::Migration[6.1]
  def up
    add_reference :heights, :account, null: true, foreign_key: true

    Height.all.each do |height|
      height.account_id = height.user_id
      height.save
    end

    change_column_null :heights, :account_id, false
    remove_reference :heights, :user, foreign_key: true
  end

  def down
    add_reference :heights, :user, null: true, foreign_key: true

    Height.all.each do |height|
      height.user_id = height.account_id
      height.save
    end

    change_column_null :heights, :user_id, false
    remove_reference :heights, :account, foreign_key: true
  end
end
