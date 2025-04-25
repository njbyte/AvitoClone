class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  
  has_many :announcements
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :nom, :prenom, presence: true
  validates :email_address, presence: true, uniqueness: true
end


