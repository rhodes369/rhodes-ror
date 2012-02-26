class AddDescriptionToMatieral < ActiveRecord::Migration
  def change
    add_column :materials, :description, :text
  end
end
