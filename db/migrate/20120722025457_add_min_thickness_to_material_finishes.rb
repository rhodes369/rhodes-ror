class AddMinThicknessToMaterialFinishes < ActiveRecord::Migration
  def change
    add_column :material_finishes, :min_thickness, :string
  end
end
