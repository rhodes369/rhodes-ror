class Material < ActiveRecord::Base
  
  default_scope order: 'materials.title ASC'  
  
  has_many :material_images
  has_many :images, :through => :material_images
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications
  
  
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  has_many :images, :dependent => :destroy 
  
  has_one :pdf, :dependent => :destroy
  has_one :material_type
    
  validates :title, presence: true
  validates_uniqueness_of :title
   
  attr_accessible :title, :description, :material_type_id, :finish_ids, 
                  :application_ids, :pdf, :images, :specifications, :technical_data
  #accepts_nested_attributes_for :images
end


  
