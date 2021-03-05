class RenameTableReferenceRangesToExamsReferences < ActiveRecord::Migration[6.1]
  def change
    rename_table :reference_ranges, :exams_references
  end
end
