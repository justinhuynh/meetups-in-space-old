class AddConstraintsToMeetups < ActiveRecord::Migration
  def up
    add_index :meetups, :name
    change_column :meetups, :location, :string, null: false, limit: 200
  end

  def down
    change_column :meetups, :location, :string, null: false
    remove_index :meetups, :name
  end
end
