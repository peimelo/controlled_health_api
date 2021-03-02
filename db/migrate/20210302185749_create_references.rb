class CreateReferences < ActiveRecord::Migration[6.1]
  def change
    create_table :references do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :references, :name, unique: true
  end
end
