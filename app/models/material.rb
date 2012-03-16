class Material < ActiveRecord::Base
   
  NEWLY_CRAFTED_LIMIT = 4
  
  has_many :images, :dependent => :destroy
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications 
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  
  has_one :material_type
  #has_one :pdf, :dependent => :destroy
     
  scope :alphabetical, self.order('title ASC') 
  scope :newly_crafted, Material.limit(NEWLY_CRAFTED_LIMIT).order('created_at DESC')
  scope :mats_with_finishes, lambda{ |fid| MaterialFinish.where(finish_id: fid) } # .map(&:material_id).uniq }   
  
  #scope :with_finishes, lambda{ |limit| Material.limit(limit) }
  #scope :mats_with_finishes, lambda{ |finish_id| MaterialFinish.where(finish_id: finish_id) }
 
  attr_accessible :title, :description, :material_type_id, 
                  :finish_ids, :finishes, :application_ids, :pdf, 
                  :images, :specifications, :technical_data

  before_destroy :delete_material_images 
  
  validates :title, presence: true, :uniqueness => true 
  validates_length_of :title, :maximum => 20, :alert => 'Title can only be 20 characters long'
  

  def get_material_type_title
    unless self.material_type_id.nil?
      material_type_title = MaterialType.find(self.material_type_id).title
    else
      material_type_title = 'None'
    end
  end

  # deletes all uploaded material images
  def delete_material_images
   if self.images.count > 0 
     self.images.each do |image|
       @image.image = nil
       @image.save
     end
   end    
  end
   

   # def index_materials(limit = 3)
   #   #return if !limit > 0
   #   self.all.limit(limit)
   #   @index_images = lambda{ |limit| Material.index_finishes(limit) }
   # end


   # def self.by_material_ids(material_ids = [1,3,4])
   #   return if !matrial_ids.count > 0
   #   self.where(':id', material.ids) 
   # end


   # 
   # # retrn array of local finish_ids
   # def self.with_finishes(finishes = [])
   #   return [] unless finishes.count > 0
   #   MaterialFinish.where(finish_id: finishes).map(&:material_id).uniq
   # end
   # 
   # # return array of local application ids
   # def self.with_applications(applications = [])
   #   return [] unless applications.count > 0
   #   Application.where(:application => applications).map(&:application.id).uniq
   # end
   # 
   # # aggregation of above filters into a colsolidated search method
   # def self.search_filters(  mat_id = nil, finishes = [], applications = [] )
   #   
   #   mats_with_material_type = self.by_mat_id
   #   mats_with_finishes = self.with_finishes
   #   mats_with_applications = applications
   #   
   #   mats_with_types = self.by_material_type_id(material_.id) unless mat.id.nil?
   #   mats_with_finishes = self.finishes(:finish_id => finishes) 
   #   mats_with_applications = self.where(:applications => applications) unless applications.size > 0  
   #   
   #   (mats_with_material_types + mates_with_finishes + mats_with_applications)
   #   
   # end   

end


