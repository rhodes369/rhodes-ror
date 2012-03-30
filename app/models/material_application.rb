class MaterialApplication < ActiveRecord::Base
  
  belongs_to :material
  belongs_to :application
  
  validates_uniqueness_of :application_id, :scope => [:material_id]
  validates :material_id, :numericality => { :only_integer => true } 
  validates :application_id, :numericality => { :only_integer => true }
  
  attr_accessible :application_id #, :material_id
  
  # remove all records that use app_id 
  def self.remove_mat_apps(app_id)  
    mat_apps = self.where(application_id: app_id)
    mat_apps_count = mat_apps.count
    mat_apps.each.map &:destroy if mat_apps_count > 0  
    
    return mat_apps_count   
  end  
end
