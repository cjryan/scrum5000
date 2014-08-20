class CreateDailyScrums < ActiveRecord::Migration
  def change
    create_table :daily_scrums do |t|
      t.text :scrum_date
      t.integer :scrum_sprint
      t.text :scrum_yesterday
      t.text :scrum_today
      t.text :scrum_blockers
      t.text :scrum_user

      t.timestamps
    end
  end
end
