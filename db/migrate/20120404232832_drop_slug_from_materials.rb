class DropSlugFromMaterials < ActiveRecord::Migration
  def up
    remove_column :materials, :slug
  end

  def down
    add_column :materials, :slug, :string
    add_index  :materials, :slug
  end
end
