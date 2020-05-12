class User < ApplicationRecord
  has_and_belongs_to_many(:users,
    :join_table => "user_connections",
    :foreign_key => "user_a_id",
    :association_foreign_key => "user_b_id")

  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: { default: 0, admin: 1 }
  has_secure_password
end
