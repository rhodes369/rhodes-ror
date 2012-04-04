class AddPdfColumnsToMaterials < ActiveRecord::Migration
  def self.up
    change_table :materials do |t|
      t.has_attached_file :pdf
    end
  end

  def self.down
    drop_attached_file :materials, :pdf
  end
end
