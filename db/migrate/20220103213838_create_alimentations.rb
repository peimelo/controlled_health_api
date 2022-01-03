class CreateAlimentations < ActiveRecord::Migration[6.1]
  def change
    create_table :alimentations do |t|
      t.datetime :date, null: false
      t.references :user, null: false
      t.references :meal, null: false

      t.timestamps
    end

    add_foreign_key :alimentations, :users
    add_foreign_key :alimentations, :meals

    add_index :alimentations, %i[date user_id], unique: true
  end
end
