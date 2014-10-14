class AddTzAndNickToUsers < ActiveRecord::Migration
  def up
    add_column :users, :user_tz, :string
    add_column :users, :user_irc_nick, :string
  end

  def down
    remove_column :users, :user_tz
    remove_column :users, :user_irc_nick
  end
end
