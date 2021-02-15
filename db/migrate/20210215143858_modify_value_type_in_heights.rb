class ModifyValueTypeInHeights < ActiveRecord::Migration[6.1]
  def change
    change_column :heights, :value, :integer
  end
end
