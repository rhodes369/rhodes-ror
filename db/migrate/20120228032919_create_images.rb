class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :orig_filename
      t.string :thumb_filename
      t.integer :material_id
      t.integer :finish_id
      t.integer :image_id

      t.timestamps
    end
    add_index :images, :material_id
    add_index :images, :finish_id
  end
end
