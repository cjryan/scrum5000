class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :current_sprint
      t.text :sprint_description

      t.timestamps
    end
  end
end
