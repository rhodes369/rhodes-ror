class AddMinThicknessToImages < ActiveRecord::Migration
  def change
    add_column :images, :min_thickness, :string
  end
end
