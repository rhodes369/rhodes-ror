class AddMaterialIdToPdfs < ActiveRecord::Migration
  def self.up
    add_column :pdfs, :material_id, :integer
  end

  def self.down
    remove_column :pdfs, :material_id
  end
end
