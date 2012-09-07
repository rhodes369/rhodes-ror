class DropMaterialFinishes < ActiveRecord::Migration
  def up
    drop_table :material_finishes
  end

  def down
    create_table :material_finishes do |t|
      t.integer :material_id
      t.integer :finish_id
    end
    add_index :material_finishes, [:material_id, :finish_id]
  end
end
