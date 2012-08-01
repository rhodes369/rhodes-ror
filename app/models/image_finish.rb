class ImageFinish < ActiveRecord::Base
  has_one :image
  has_one :finish
  
  validates_uniqueness_of :finish_id, :scope => [:image_id]
  
  attr_protected :image_id, :finish_id. :min_thickness
  
  def after_initalize
    self.min_thickness ||= "1&#34; minimum thickness" # 1 inch default for now
  end  
  
end
