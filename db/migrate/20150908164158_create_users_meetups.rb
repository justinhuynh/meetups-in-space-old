class CreateUsersMeetups < ActiveRecord::Migration
  def change
    create_table :user_meetups, id: false do |table|
      table.belongs_to :user, index: true
      table.belongs_to :meetup, index: true
    end
  end
end
