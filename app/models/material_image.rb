class MaterialImage < ActiveRecord::Base
 
  belongs_to :material
  belongs_to :image
  
  validates_uniqueness_of :image_id, :scope => [:material_id]
  validates :material_id, :numericality => { :only_integer => true } 
  validates :image_id, :numericality => { :only_integer => true } 
  
  attr_accessible :material_id, :image_id                    
  
end
