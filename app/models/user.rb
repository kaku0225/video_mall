# frozen_string_literal: true

# user model
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  enum role: { normal: 0, admin: 1 }
  validates :name, presence: true
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: Settings.user.password.min_length }, confirmation: true
  validates :password_confirmation, presence: true
  validates :role, presence: true

  before_create :encrypt_password

  private

  def encrypt_password
    self.password = Digest::SHA1.hexdigest(password.to_s)
  end
end
