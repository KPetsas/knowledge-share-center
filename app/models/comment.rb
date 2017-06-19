class Comment < ApplicationRecord
  validates :description, presence: true, length: { minimum: 4, maximum: 140 }
  belongs_to :expert
  belongs_to :guide
  validates :expert_id, presence: true
  validates :guide_id, presence: true
  default_scope -> { order(updated_at: :desc) }  # descending order
end
