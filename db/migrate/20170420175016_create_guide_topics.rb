class CreateGuideTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :guide_topics do |t|
      t.integer :guide_id
      t.integer :topic_id
    end
  end
end
