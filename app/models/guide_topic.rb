class GuideTopic < ApplicationRecord
  belongs_to :topic
  belongs_to :guide
end
