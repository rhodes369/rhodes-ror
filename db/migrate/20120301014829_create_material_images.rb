class CreateMaterialImages < ActiveRecord::Migration
  def change
    create_table :material_images do |t|
      t.integer :material_id
      t.integer :image_id
      t.integer :finish_id
    end
    
    add_index :material_images, :material_id
    add_index :material_images, :image_id
  end
end