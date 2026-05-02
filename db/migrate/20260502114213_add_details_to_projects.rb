class AddDetailsToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :tagline, :string
    add_column :projects, :hero_description, :text
    add_column :projects, :duration, :string
    add_column :projects, :format, :string
    add_column :projects, :reach, :string
    add_column :projects, :cost, :string
    add_column :projects, :about_description, :text
    add_column :projects, :about_quote, :text
    add_column :projects, :curriculum_title, :string
    add_column :projects, :curriculum_description, :text
    add_column :projects, :timeline_title, :string
    add_column :projects, :timeline_description, :text
    add_column :projects, :partnership_title, :string
    add_column :projects, :partnership_description, :text
    add_column :projects, :tracks, :jsonb
    add_column :projects, :timeline_steps, :jsonb
    add_column :projects, :partnership_bullets, :jsonb
  end
end
