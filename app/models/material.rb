class Material < ActiveRecord::Base
   
  NEWLY_CRAFTED_WITH_IMAGES_LIMIT = 4
  
  has_many :images, :dependent => :destroy
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications 
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  
  has_one :material_type
  #has_one :pdf, :dependent => :destroy
  
  attr_accessible :title, :description, :material_type_id, 
                  :finish_ids, :finishes, :application_ids, :pdf, 
                  :images, :specifications, :technical_data  
      
  scope :alphabetical, self.order('title ASC') 
  scope :newly_crafted, self.order('created_at DESC')
  # i hate to do manual sql (for a NOT LIKE) here but this is the data the client wants
  scope :newly_crafted_sidebar, self.find_by_sql("SELECT * from materials 
                                      WHERE title NOT LIKE '%antique%' 
                                      ORDER BY created_at DESC")
  scope :antique_in_title, self.where('title LIKE ?', '%antique%').order('title ASC') 


  before_destroy :delete_material_images 
  
  validates :title, presence: true, :uniqueness => true 
  validates_length_of :title, :maximum => 25, :alert => 'Title can only be 25 characters long'
  
   
  # filter out all newly crafted mats without images
  def self.newly_crafted_with_images
    with_images = []
    self.newly_crafted.each { |mat| with_images << mat if mat.images.count > 0 } 
    return with_images.take(NEWLY_CRAFTED_WITH_IMAGES_LIMIT)
  end
  
  def self.with_finish(finish_id)
    with_finish = []
    MaterialFinish.where(finish_id: finish_id).each { |mat| with_finish << mat }
    
    return with_finish
  end
  
  def material_type_title
    unless self.material_type_id.nil?
      material_type_title = MaterialType.find(self.material_type_id).title
    else
      material_type_title = 'None'
    end
  end

  # def self.update_default_image
  # 
  # end

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


