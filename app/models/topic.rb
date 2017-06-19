class Topic < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
  has_many :guide_topics
  has_many :guides, through: :guide_topics
end
