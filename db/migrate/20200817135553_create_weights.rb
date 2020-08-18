class CreateWeights < ActiveRecord::Migration[6.0]
  def change
    create_table :weights do |t|
      t.datetime :date, null: false
      t.decimal :value, precision: 5, scale: 2, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
