class Meetup < ActiveRecord::Base
  validates :name, :location, :description, presence: true
  validates :name, uniqueness: true
  validates :location, length: { maximum: 200 }

  has_many :user_meetups
  has_many :users,
    through: :user_meetups
end
