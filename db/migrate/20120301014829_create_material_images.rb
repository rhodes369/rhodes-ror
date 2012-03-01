class CreateMaterialImages < ActiveRecord::Migration
  def change
    create_table :material_images do |t|
      t.integer :material_id
      t.integer :image_id
    end
    
    add_index :material_images, [:material_id, :image_id]
  end
end