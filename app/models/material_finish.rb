class MaterialFinish < ActiveRecord::Base
 
  belongs_to :material
  belongs_to :finish
  
  validates_uniqueness_of :finish_id, :scope => [:material_id]
  validates :material_id, :numericality => { :only_integer => true } 
  validates :finish_id, :numericality => { :only_integer => true } 
  
  attr_accessible :finish_id, min_thickness                
  
  # remove all records that use finish_id 
  def self.remove_mat_finishes(finish_id)  
    mat_finishes = self.where(finish_id: finish_id)
    mat_finishes_count = mat_finishes.count
    mat_finishes.each.map &:destroy if mat_finishes_count > 0  
    
    return mat_finishes_count
  end  
end
