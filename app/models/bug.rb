class Bug < ApplicationRecord
  mount_uploader :image, AttachmentUploader # Tells rails to use this uploader for this model.
  belongs_to :user
  belongs_to :project
  extend FriendlyId
  friendly_id :title, use: :slugged
  enum bug_type: { Feature: 1, Bug: 2 }
  enum status: { New: 1, Started: 2, Complete: 3, Resolved: 3 }
  def bug_type
  end
  def self.bug_type
    {  Bug: 1, Feature: 2 }
  end
  def status
  end
  def self.status
   { New: 1, Started: 2, Complete: 3, Resolved: 4 }
  end
end