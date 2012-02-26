class MaterialFinish < ActiveRecord::Base
 
  belongs_to :material
  belongs_to :finish
  
  validates_uniqueness_of :finish_id, :scope => [:material_id]
  
end
