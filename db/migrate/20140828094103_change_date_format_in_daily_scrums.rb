class ChangeDateFormatInDailyScrums < ActiveRecord::Migration
  def up
    #change_column :daily_scrums, :scrum_date, :date
    execute <<-SQL
      ALTER TABLE "daily_scrums"
      ALTER COLUMN "scrum_date"
      TYPE date USING scrum_date::date
    SQL
  end

  def down
    #change_column :daily_scrums, :scrum_date, :text
    execute <<-SQL
      ALTER TABLE "daily_scrums"
      ALTER COLUMN "scrum_date"
      TYPE text USING scrum_date::text
    SQL
  end
end
