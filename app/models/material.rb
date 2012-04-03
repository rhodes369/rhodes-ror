class Material < ActiveRecord::Base 

  has_many :images, :dependent => :destroy
  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications 
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  has_one  :material_type
  #has_one :pdf, :dependent => :destroy
  
  attr_accessible :title, :description, :material_type_id, 
                  :finish_ids, :finishes, :application_ids, :pdf, 
                  :images, :specifications, :technical_data, :slug 
      
  scope :alphabetical, self.order('title ASC') 
  scope :newly_crafted, self.order('created_at DESC')
  
  scope :newly_crafted_without_antiques, 
        self.find_by_sql("SELECT * from materials 
                          WHERE title NOT LIKE '%antique%' 
                          ORDER BY created_at DESC")
  scope :antique_in_title, self.where('title LIKE ?', '%antique%').order('title ASC')  
  scope :with_mat_type, lambda { |mat_type_id| where('material_type_id = ?', mat_type_id) }

  is_sluggable :title # for slugged gem

  before_destroy :delete_material_images 
  
  validates :title, presence: true, :uniqueness => true 
  validates_length_of :title, :maximum => 25, :alert => 'Title can only be 25 characters long'
  
   
  # filter out all newly crafted mat or 'antique' in title
  def self.newly_crafted(filters = {})
    
    logger.debug "looking up newly_crafted mats using filters: #{filters.inspect}"
    
    results = []
          
    self.newly_crafted_without_antiques.each do |mat| 
     
     unless filters.empty? # filter results via pulldowns
     
        # filter for mat type
        if !filters[:mat_type_id].blank? 
          if mat.material_type_id == filters[:mat_type_id].to_i 
            results << mat unless results.include?(mat)
          end
        end
       
    
        # filter for finish type
        if !filters[:mat_finish_id].blank?
          if mat.finishes.map(&:id).include?( filters[:mat_finish_id].to_i )  
            results << mat unless results.include?(mat)
          end
        end
       
        # filter for application type
        if !filters[:mat_app_id].blank?
          if mat.applications.map(&:id).include?( filters[:mat_app_id].to_i )  
            results << mat unless results.include?(mat)
          end
        end  
         
      else # no filters currently set so show everything      
        results << mat # unless results.include?(mat)
      end    
    end
    
    # since our array loses the original sql ordering, reverse   
    results = order_results_hash(results) 
     
    return results
  end
  


  # filter out all newly crafted mat or 'antique' in title
  def self.antique_in_title_results(filters = {})
    
    logger.debug "looking up mats with 'antique' in title using filters: #{filters.inspect}"
    
    results = []
          
    self.antique_in_title.each do |mat| 
     
     unless filters.empty? # filter results via pulldowns
     
        # filter for mat type
        if !filters[:mat_type_id].blank? 
          if mat.material_type_id == filters[:mat_type_id].to_i 
            results << mat unless results.include?(mat)
          end
        end
       
    
        # filter for finish type
        if !filters[:mat_finish_id].blank?
          if mat.finishes.map(&:id).include?( filters[:mat_finish_id].to_i )  
            results << mat unless results.include?(mat)
          end
        end
       
        # filter for application type
        if !filters[:mat_app_id].blank?
          if mat.applications.map(&:id).include?( filters[:mat_app_id].to_i )  
            results << mat unless results.include?(mat)
          end
        end  
         
      else # no filters currently set so show everything    
        results << mat # unless results.include?(mat)
      end    
    end
    
    # since our array loses the original sql ordering, reverse   
    results = order_results_hash(results) 
     
    return results
  end


  def self.with_finish(finish_id)
    with_finish = []
    MaterialFinish.where(finish_id: finish_id).each { |mat| with_finish << mat }    
    return with_finish
  end

  # set all instances using this mat_type_id to nil
  def self.reset_all_material_types(mat_type_id)
    mat_types = Material.where(material_type_id: mat_type_id)
    
    if mat_types.count > 0 
      mat_types.each do |mat|
        mat.material_type_id = nil
        mat.save!
      end
    end 
    
    return mat_types.count   
  end


  # sort from newest to oldest with the default @ the beginning
  def sort_thumb_images
    return [] if self.images.count == 0
    
    self.images.sort { |a,b| b.created_at <=> a.created_at }
    
    default_image = Image.find self.default_image_id 
    self.images.unshift default_image # put default image @ beginning
    self.images.uniq # make sure array is unique  
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

  
  private 
  
  def self.order_results_hash(results = {})
    results.sort! { |a,b| b.created_at <=> a.created_at } # reverse!
  end
end