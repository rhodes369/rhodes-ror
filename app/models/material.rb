class Material < ActiveRecord::Base 
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
  
  scope :newly_crafted_without_antiques, 
        self.find_by_sql("SELECT * from materials 
                          WHERE title NOT LIKE '%antique%' 
                          ORDER BY created_at DESC")
  scope :antique_in_title, self.where('title LIKE ?', '%antique%').order('title ASC')  
  
  # scope :newly_crafted_with_images, lambda {
  #   with_images = []
  #   self.newly_crafted_without_antiques.each do |mat| 
  #     with_images << mat if mat.images.count > 0 
  #   end
  #   return with_images
  # }

  scope :with_mat_type, lambda { |mat_type_id| where('material_type_id = ?', mat_type_id) }

  before_destroy :delete_material_images 
  
  validates :title, presence: true, :uniqueness => true 
  validates_length_of :title, :maximum => 25, :alert => 'Title can only be 25 characters long'
  
   
  # filter out all newly crafted mats without images or 'antique' in title
  def self.newly_crafted_with_images(filters = {})
    logger.debug "newly_crafted_images filters: #{filters.inspect}"
    with_images = []
    
    self.newly_crafted_without_antiques.each do |mat| 
      unless filters[:mat_type_id].blank?
        if mat.material_type_id == filters[:mat_type_id].to_i
          with_images << mat if mat.images.count > 0 
        end
      else
        with_images << mat if mat.images.count > 0
      end
    end 
    
    return with_images
  end



  
  def self.with_finish(finish_id)
    with_finish = []
    MaterialFinish.where(finish_id: finish_id).each { |mat| with_finish << mat }
    
    return with_finish
  end


  def default_large_image
    unless self.default_image_id.nil?
      unless Image.find_by_id(self.default_image_id).nil?
        default_image = Image.find_by_id self.default_image_id
        return default_image.image.url(:large) # paperclip
      end
    end    
  end


  def set_default_image(image_id)
    return nil unless image_id.is_a?(Numeric) and image_id > 0
    self.default_image_id = image_id
    return true if self.save!
  end
  
  
  def material_type_title
    material_type_title = '' # don't show anything unless mat type title exists
    unless self.material_type_id.nil?
      material_type_title = MaterialType.find(self.material_type_id).title
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


