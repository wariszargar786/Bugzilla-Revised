class ProjectUser < ApplicationRecord
  validates :user_id , presence: true
  validates :project_id , presence: true
  belongs_to :project
  belongs_to :user
end