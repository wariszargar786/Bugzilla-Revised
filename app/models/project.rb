class Project < ApplicationRecord
  has_many :users
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :bugs
  has_many :project_users
  has_many :users, through: :project_users
  validates :title, presence: true, uniqueness: true, length: {minimum: 5 , maximum: 250}
  validates :description, presence: true, length: {minimum: 5 , maximum: 1000}
end
