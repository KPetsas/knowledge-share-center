class Message < ApplicationRecord
  belongs_to :expert
  validates :content, presence: true
  validates :expert_id, presence: true

  def self.most_recent
    order(:created_at).last(20)
  end
end
