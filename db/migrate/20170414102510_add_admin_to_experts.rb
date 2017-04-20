class AddAdminToExperts < ActiveRecord::Migration[5.0]
  def change
    add_column :experts, :admin, :boolean, default: false
  end
end
