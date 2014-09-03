class ChangeUserEmailToIdInDailyScrums < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE daily_scrums ds
      SET scrum_user = us.id
      FROM users us
      WHERE ds.scrum_user = us.email;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE daily_scrums ds
      SET scrum_user = us.email
      FROM users us
      WHERE ds.scrum_user = us.id
    SQL
  end
end
