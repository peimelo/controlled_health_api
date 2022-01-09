class AddAccountIdToWeights < ActiveRecord::Migration[6.1]
  def up
    add_reference :weights, :account, null: true, foreign_key: true

    Weight.all.each do |weight|
      weight.account_id = weight.user_id
      weight.save
    end

    change_column_null :weights, :account_id, false
    remove_reference :weights, :user, foreign_key: true
  end

  def down
    add_reference :weights, :user, null: true, foreign_key: true

    Weight.all.each do |weight|
      weight.user_id = weight.account_id
      weight.save
    end

    change_column_null :weights, :user_id, false
    remove_reference :weights, :account, foreign_key: true
  end
end
