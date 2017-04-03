class Guide < ApplicationRecord
  validates :title, presence: true
  validates :instructions, presence: true, length: {minimum: 5, maximum: 500}
  belongs_to :expert
  validates :expert_id, presence: true
  default_scope -> { order(updated_at: :desc) }  # descending order
end
