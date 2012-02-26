class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :title
      t.integer :material_type_id

      t.timestamps
    end
  end
end
