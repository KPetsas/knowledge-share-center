class AddPasswordDigestToExperts < ActiveRecord::Migration[5.0]
  def change
    add_column :experts, :password_digest, :string
  end
end
