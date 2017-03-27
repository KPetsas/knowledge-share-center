class ChangeColumnTypeInGuides < ActiveRecord::Migration[5.0]
  def change
    change_column :guides, :instructions, :text
  end
end
