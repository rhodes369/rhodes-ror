class AddSearchIconImageIdToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :search_icon_image_id, :int
  end
end
