class AddIndexToUserMeetups < ActiveRecord::Migration
  # (note for personal reference)
  # this enforces uniqueness of the association, so we're not adding meetups for the same user more than once
  def up
    add_index :user_meetups, [:user_id, :meetup_id], unique: true
  end

  def down
    remove_index :user_meetups, [:user_id, :meetup_id], unique: true
  end
end
