class CreateMaterialApplications < ActiveRecord::Migration
  def change
    create_table :material_applications do |t|
      t.integer :material_id
      t.integer :application_id
    end
    add_index :material_applications, [:material_id, :application_id]
  end
end
