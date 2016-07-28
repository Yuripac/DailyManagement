class AddUserIdToDailies < ActiveRecord::Migration
  def change
    add_column :dailies, :user_id, :integer
    add_index :dailies, [:user_id, :team_id, :created_at], unique: true
  end
end
