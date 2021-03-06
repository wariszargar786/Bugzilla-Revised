class Bug < ApplicationRecord
  mount_uploader :image, AttachmentUploader # Tells rails to use this uploader for this model.
  scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
  scope :completed_between, lambda {|start_date, end_date| where("completed_at >= ? AND completed_at <= ?", start_date, end_date )}

  belongs_to :user
  belongs_to :project
  has_many :bug_users
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true, uniqueness: true, length: {minimum: 3 , maximum: 200}
  validates :description, presence: true, length: {minimum: 3 , maximum: 1000}
  enum bug_type: { Feature: 1, Bug: 2 }
  enum status: { New: 1, Started: 2, Complete: 3, Resolved: 4 }
  def self.bug_type_list
    {  Bug: 1, Feature: 2 }
  end
  def self.bug_status_list
   { New: 1, Started: 2, Complete: 3, Resolved: 4 }
  end
end