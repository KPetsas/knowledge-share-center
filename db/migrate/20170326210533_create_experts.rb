class CreateExperts < ActiveRecord::Migration[5.0]
  def change
    create_table :experts do |t|
      t.string :expertname
      t.string :email
      t.timestamps
    end
  end
end
