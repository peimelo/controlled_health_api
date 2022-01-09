class AddAccountIdToAlimentations < ActiveRecord::Migration[6.1]
  def up
    add_reference :alimentations, :account, null: true, foreign_key: true

    Alimentation.all.each do |alimentation|
      alimentation.account_id = alimentation.user_id
      alimentation.save
    end

    change_column_null :alimentations, :account_id, false
    remove_reference :alimentations, :user, foreign_key: true
  end

  def down
    add_reference :alimentations, :user, null: true, foreign_key: true

    Alimentation.all.each do |alimentation|
      alimentation.user_id = alimentation.account_id
      alimentation.save
    end

    change_column_null :alimentations, :user_id, false
    remove_reference :alimentations, :account, foreign_key: true
  end
end
