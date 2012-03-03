class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :title
      t.integer :material_type_id
      t.integer :default_image_id
      t.integer :pdf_id
      t.text :description

      t.timestamps
    end
    add_index :materials, :material_type_id
    add_index :materials, :default_image_id
  end
end
