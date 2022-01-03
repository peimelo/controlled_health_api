class CreateMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :meals do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :meals, :name, unique: true
  end
end
