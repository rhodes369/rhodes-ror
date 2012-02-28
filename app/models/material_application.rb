class MaterialApplication < ActiveRecord::Base
  
  belongs_to :material
  belongs_to :application
  
  validates_uniqueness_of :application_id, :scope => [:material_id]
  validates :material_id, :numericality => { :only_integer => true } 
  validates :application_id, :numericality => { :only_integer => true }
  
  attr_accessible :application_id, :material_id
end
