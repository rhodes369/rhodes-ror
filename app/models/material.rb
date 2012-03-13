class Material < ActiveRecord::Base
   
  has_many :images, :dependent => :destroy
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications
  
  
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  
  # has_one :pdf, :dependent => :destroy
  has_one :material_type
     
  default_scope order: 'materials.title ASC'  
       
  #by_material_types = where(material_id = ?, mat  
    
  validates :title, presence: true, :uniqueness => true
  validates_uniqueness_of :title
   
  attr_accessible :title, :description, :material_type_id, 
                  :finish_ids, :application_ids, :pdf, 
                  :images, :specifications, :technical_data

  before_destroy :delete_material_images 
       
       
  # our search filters
  def self.by_material(mat = nil)
    return if mat.nil?
    self.find(mat) 
  end                            
  
  return array material_type
  def self.by_material_type(mat = nil)
    return if mat.nil?
    where('material_type_id = ?', mat.id) 
  end
  
  # retrn array of local finish_ids
  def self.with_finishes(finishes = [])
    return [] unless finishes.count > 0
    MaterialFinish.where(finish_id: finishes).map(&:material_id).uniq
  end
  
  # return array of local application ids
  def self.with_applications(applications = [])
    return [] unless applications.count > 0
    Application.where(application_id: applications).map(&:application.id).uniq
  end
  
  # aggregation of above filters into a colsolidated search method
  def self.search_filters(mat = nil, finishes = [], applications = [])
    materials = self.find(mat.id)
    mats_with_types = []
    mats_with_filters = []
    mats_with_applications = []
    
    mats_with_types = self.by_material_type(mat) unless mat.nil?
    mats_with_finishes = self.with_finishes(finishes) 
    mats_with_applications = self.where(:applications => applications) unless applications.size > 0
    
    ( mats_with_types + mats_with_finishes + mats_with_applications) #.map(&:material_id)
  end   
end


  
