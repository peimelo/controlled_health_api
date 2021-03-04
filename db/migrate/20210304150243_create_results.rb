class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.date :date, null: false
      t.string :description, null: false

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :results, %i[date description user_id], unique: true
  end
end
