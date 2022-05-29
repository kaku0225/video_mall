# frozen_string_literal: true

# user model
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_secure_password

  enum role: { normal: 0, admin: 1 }
  validates :name, presence: true
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password,
            presence: true,
            length: { minimum: Settings.user.password.min_length },
            allow_nil: true

  validates :role, presence: true
end
