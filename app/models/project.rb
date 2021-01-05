class Project < ApplicationRecord
  has_many :users
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true, uniqueness: true, length: {minimum: 5 , maximum: 250}
  validates :description, presence: true, length: {minimum: 5 , maximum: 1000}
  validates :user_id, presence: true
end
