class Expert < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :expertname, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
  has_many :guides, dependent: :destroy
  has_secure_password
  # has_secure_password enforces the user to set password and password_confirmation
  # on sign up, even if allow_nil is true (we need that for the edit action)
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
end
