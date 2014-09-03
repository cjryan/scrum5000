class ChangeScrumUserToIntegerInDailyScrums < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE "daily_scrums"
      ALTER COLUMN "scrum_user"
      TYPE integer USING scrum_user::integer
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE "daily_scrums"
      ALTER COLUMN "scrum_user"
      TYPE text USING scrum_user::text
    SQL
  end
end
