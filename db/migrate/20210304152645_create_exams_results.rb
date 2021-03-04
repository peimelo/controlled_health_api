class CreateExamsResults < ActiveRecord::Migration[6.1]
  def change
    create_table :exams_results do |t|
      t.decimal :value, null: false, precision: 10, scale: 2

      t.references :exam, null: false, foreign_key: true
      t.references :result, null: false, foreign_key: true

      t.timestamps
    end

    add_index :exams_results, %i[exam_id result_id], unique: true
  end
end
