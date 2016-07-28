class CreateDailies < ActiveRecord::Migration
  def change
    create_table :dailies do |t|
      t.string :done
      t.string :doing
      t.string :impediments
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
