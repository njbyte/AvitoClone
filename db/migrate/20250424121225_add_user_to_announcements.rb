class AddUserToAnnouncements < ActiveRecord::Migration[8.0]
  def change
    add_reference :announcements, :user, foreign_key: true  # remove "null: false"
  end
end
