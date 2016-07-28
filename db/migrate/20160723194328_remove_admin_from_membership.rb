class RemoveAdminFromMembership < ActiveRecord::Migration
  def change
    remove_column :memberships, :admin, :boolean
  end
end
