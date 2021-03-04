class CreateReferenceRanges < ActiveRecord::Migration[6.1]
  # rubocop: disable Metrics/MethodLength
  def change
    create_table :reference_ranges do |t|
      t.string :gender, null: true
      t.decimal :minimum_age, precision: 6, scale: 3, null: true
      t.decimal :maximum_age, precision: 6, scale: 3, null: true
      t.decimal :minimum_value, precision: 10, scale: 2, null: true
      t.decimal :maximum_value, precision: 10, scale: 2, null: true
      t.boolean :default, null: false, default: false

      t.references :exam, null: false, foreign_key: true
      t.references :reference, null: true, foreign_key: true

      t.timestamps
    end
  end
end
