class Image::ImageFinishes < ActiveRecord::Base
  has_one :image
  has_one :finish
  
  validates_uniqueness_of :finish_id, :scope => [:image_id]
  validates :material_id, :numericality => { :only_integer => true } 
  validates :finish_id, :numericality => { :only_integer => true } 
  
  attr_accessible :image_id, :finish_id
end
