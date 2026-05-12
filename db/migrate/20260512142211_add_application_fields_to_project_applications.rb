class AddApplicationFieldsToProjectApplications < ActiveRecord::Migration[8.1]
  def change
    add_column :project_applications, :age_group, :string
    add_column :project_applications, :marital_status, :string
    add_column :project_applications, :course_track, :string
  end
end
