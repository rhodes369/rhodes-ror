class Material < ActiveRecord::Base
  
  default_scope order: 'materials.title ASC'  
  
  has_many :images, :dependent => :destroy
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications
  
  
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  
  has_one :pdf, :dependent => :destroy
  has_one :material_type
    
  validates :title, presence: true, :uniqueness => true
  validates_uniqueness_of :title
   
  attr_accessible :title, :description, :material_type_id, :finish_ids, 
                  :application_ids, :pdf, :images, :specifications, :technical_data

  before_destroy :delete_material_images

private 
  def delete_material_images
    self.images.each do |image|
      @image.image = nil
      @image.save
    end
  end  
  
end


  
