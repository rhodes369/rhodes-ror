class ImageFinish < ActiveRecord::Base
  has_one :image
  has_one :finish
  
  validates_uniqueness_of :finish_id, :scope => [:image_id]
  
  attr_protected :image_id, :finish_id, :min_thickness
  
end
