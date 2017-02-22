class UserMeetup < ActiveRecord::Base
  validates_uniqueness_of :user_id, scope: :meetup_id

  belongs_to :meetup
  belongs_to :user
end
