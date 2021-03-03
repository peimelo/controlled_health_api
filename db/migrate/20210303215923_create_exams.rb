class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.string :name, null: false
      t.references :unit, null: true, foreign_key: true
      t.string :ancestry

      t.timestamps
    end
    add_index :exams, :ancestry
    add_index :exams, %i[name ancestry], unique: true
  end
end
