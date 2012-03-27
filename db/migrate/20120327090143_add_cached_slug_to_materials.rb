class AddCachedSlugToMaterials < ActiveRecord::Migration
  
  def self.up
    add_column :materials, :cached_slug, :string
    add_index  :materials, :cached_slug
  end

  def self.down
    remove_column :materials, :cached_slug
  end
  
end
