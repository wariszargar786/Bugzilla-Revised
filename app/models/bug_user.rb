class BugUser < ApplicationRecord
  belongs_to :bug
  belongs_to :user
  validates :deadline , presence: true
  validates :user_id , presence: true

end
