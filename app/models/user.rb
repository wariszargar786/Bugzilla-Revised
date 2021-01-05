class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name , presence: true, length: {minimum: 3 , maximum: 50 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { Developer: 1, Manager: 2, QA: 3 }
  def before_save
    self.email = email.downcase
  end
  def user_role
  end
  def self.user_role
    { Developer: 1, Manager: 2, QA: 3 }
  end
end
