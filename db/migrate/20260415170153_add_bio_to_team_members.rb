class AddBioToTeamMembers < ActiveRecord::Migration[8.1]
  def change
    add_column :team_members, :bio, :text
  end
end
