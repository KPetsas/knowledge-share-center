class AddExpertIdToGuides < ActiveRecord::Migration[5.0]
  def change
    add_column :guides, :expert_id, :integer
  end
end
