class Material < ActiveRecord::Base 

  has_many :applications, :through => :material_applications 
  has_many :material_applications, :dependent => :destroy
  has_one  :material_type
  has_many :images, :dependent => :destroy
  has_many :standard_values
  accepts_nested_attributes_for :standard_values, :allow_destroy => true
  
  has_attached_file :pdf, 
         :path => ":rails_root/public/system/materials/:attachment/:id/:filename",
         :url => "/system/materials/:attachment/:id/:filename",
         :dependent => :destroy
      
  attr_accessible :title, :description, :material_type_id, 
                  :application_ids, :images, :specifications, 
                  :technical_data, :pdf, :pdf_file_name, 
                  :pdf_content_type, :pdf_file_size, :standard_values_attributes

  is_sluggable :title # for slugged gem 
                         
  scope :alphabetical, self.order('title ASC') 
  scope :newly_crafted_without_antiques, 
    where("title NOT LIKE '%antique%'").order("created_at DESC")
  scope :antique_in_title, self.where('title LIKE ?', '%antique%').order('title ASC')  
  scope :with_mat_type, lambda { |mat_type_id| where('material_type_id = ?', mat_type_id) }

  validates_presence_of :title
  validates_uniqueness_of :title
  validates :title, :length => { :in => 3..40 }
  validates_attachment :pdf, 
    :content_type => { :content_type => ['application/pdf'] },
    :size => { :in => 0..20.megabytes }

  # before_post_process :transliterate_file_name
  # before_destroy :delete_all_related_image_attachments    
     
  # filter mat search results based on type ( newly_crafted or antique_in_title)
  def self.filter_search_results(filters = {}, mat_types = 'newly_crafted')
    results = []
    logger.debug "filtering search results for mat_types #{mat_types} filters: #{filters.inspect}"
    
    if mat_types == 'newly_crafted'
      mats = self.newly_crafted_without_antiques
    elsif mat_types == 'antique_in_title'
      mats = self.antique_in_title
    end
    
    mats.each do |mat|
      
      results << mat # add by default, filter if needed

      # filter mat types
      unless filters[:mat_type_id].blank? 
        unless mat.material_type_id == filters[:mat_type_id].to_i
          results.delete mat if results.include?(mat)
        end
      end

      # filter finishes
      unless filters[:mat_finish_id].blank?  
        unless mat.finishes(true).include?(filters[:mat_finish_id].to_i)
          results.delete mat if results.include?(mat)
        end
      end

      # filter applications
      unless filters[:mat_app_id].blank?  
        unless mat.applications.map(&:id).include?( filters[:mat_app_id].to_i )
          results.delete mat if results.include?(mat)
        end
      end
    end
    
    return results.uniq      
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


  # return array of all mat image finish objects or ids
  def finishes(ids_only = nil)
    finishes = []
    finish_ids = self.images.where('finish_id IS NOT NULL').map(&:finish_id)
    
    if !ids_only.nil?
      finishes = finish_ids 
    else  # return array of full objects
      finish_ids.map do |fid| 
        fin = Finish.find_by_id fid
        finishes << fin unless fin.nil?
      end
    end
    return finishes
  end


  
  # return array of all mat.images finish_ids combined
  def images_with_finish(finish_id = nil)
    return [] if finish_id.nil? or self.images.nil? 
    # otherwize...
    return self.images.where(finish_id: finish_id)
  end

  # sort from newest to oldest with the default @ the beginning
  def sort_thumb_images(use_search_icon_image = nil)
    return [] if self.images.count == 0
    
    self.images.sort { |a,b| b.created_at <=> a.created_at }
    
    default_image = Image.find self.default_image_id 
    search_icon_image = Image.find self.search_icon_image_id
    
    self.images.unshift default_image # put default image @ beginning
    self.images.unshift search_icon_image unless use_search_icon_image.nil?
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

  def set_search_icon_image(image_id)
    return nil unless image_id.is_a?(Numeric) and image_id > 0
    self.search_icon_image_id = image_id
    return true if self.save!
  end  
  
  def material_type_title
    # show blank unless title exists
    return '' if self.material_type_id.nil? 
    MaterialType.find(self.material_type_id).title
  end
end