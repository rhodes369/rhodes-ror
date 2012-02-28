class Material < ActiveRecord::Base
  
  has_one :material_type
  
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications  
  
  validates :title, presence: true
  validates_uniqueness_of :title
end
