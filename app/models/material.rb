class Material < ActiveRecord::Base 

  has_many :finishes, :through => :material_finishes 
  has_many :applications, :through => :material_applications 
  has_many :material_finishes, :dependent => :destroy
  has_many :material_applications, :dependent => :destroy
  has_one  :material_type
  has_many :images, :dependent => :destroy
  has_attached_file :pdf, 
         :path => ":rails_root/public/system/materials/:attachment/:id/:filename",
         :url => "/system/materials/:attachment/:id/:filename",
         :dependent => :destroy
         
  attr_accessible :title, :description, :material_type_id, 
                  :finish_ids, :finishes, :application_ids, 
                  :images, :specifications, :technical_data,
                  :pdf, :pdf_file_name, :pdf_content_type, :pdf_file_size

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
     
  # filter out all newly crafted mat or 'antique' in title
  def self.newly_crafted(filters = {})
    
    logger.debug "looking up newly_crafted mats using filters: #{filters.inspect}"
    
    results = []
          
    self.newly_crafted_without_antiques.each do |mat| 
     
     unless filters.empty? # filter results via pulldowns
     
        # filter for mat type
        unless filters[:mat_type_id].blank? 
          if mat.material_type_id == filters[:mat_type_id].to_i 
            results << mat unless results.include?(mat)
          end
        end
       
    
        # # filter for finish type
        unless filters[:mat_finish_id].blank?
          if mat.all_finish_ids.include?(filters[:mat_finish_id].to_i) 
            results << mat unless results.include?(mat)
          end
        end
       
        # filter for application type
        unless filters[:mat_app_id].blank?
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
    
    logger.debug "looking up antique_in_title_results using filters: #{filters.inspect}"
    
    results = []

    self.antique_in_title.each do |mat| 
     
     unless filters.empty? # filter results via pulldowns
     
        # filter for mat type
        unless filters[:mat_type_id].blank? 
          if mat.material_type_id == filters[:mat_type_id].to_i 
            results << mat unless results.include?(mat)
          end
        end
       
    
        # # filter for finish type
        unless filters[:mat_finish_id].blank?
          if mat.all_finish_ids.include?(filters[:mat_finish_id].to_i) 
            results << mat unless results.include?(mat)
          end
        end
       
        # filter for application type
        unless filters[:mat_app_id].blank?
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


  # return array of all mat finish ids + mat.images finish_ids combined
  def all_finish_ids
    if self.images.nil?
      return self.finishes.map(&:id) 
    else
      image_finish_ids = self.images.where('finish_id IS NOT NULL').map(&:finish_id)
      return self.finishes.map(&:id).concat(image_finish_ids)
    end
  end


  # return array of all mat.images finish_ids combined
  def all_images_with_finish(finish_id = nil)
    return nil if finish_id.nil? or self.images.nil? 
    
    images_with_finish = self.images.where(finish_id: finish_id)
    return images_with_finish
  end

  # sort from newest to oldest with the default @ the beginning
  def sort_thumb_images(use_search_icon_image = nil)
    return [] if self.images.count == 0
    
    self.images.sort { |a,b| b.created_at <=> a.created_at }
    
    default_image = Image.find self.default_image_id 
    search_icon_image = Image.find self.search_icon_image_id
    
    # self.images.unshift default_image 
    # put search icon image @ beginning for index page (no filters)
    
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

  
  private 

  # manually destroy all related paperclip attachments
  # def delete_all_related_image_attachments  
  #   # manually make sure image records get removed
  #   image_ids = self.images.map &:id
  #   image_ids.each { |id| i = Image.find id; i.destroy }
  #   
  #   remaining_images = Image.find_all_by_id(image_ids)
  #   if remaining_images.count > 0
  #     logger.debug "#{remaining_images.count} images: still exist: #{remaining_images.to_s} after mat destroy for mat: #{self.id}"
  #     self.errors[:base] << "- #{remaining_images.count} images still exist"
  #     return false
  #   else
  #     return true
  #   end
  # end
  
  
  # def transliterate_file_name
  #   extension = File.extname(local_file_name).gsub(/^\.+/, '')
  #   filename = local_file_name.gsub(/\.#{extension}$/, '')
  #   self.local.instance_write(:filename, "#{UrlFriendlyFilenames::transliterate(filename)}.#{UrlFriendlyFilenames::transliterate(extension)}")
  # end
  
  def self.order_results_hash(results = {})
    results.sort! { |a,b| b.created_at <=> a.created_at } # reverse!
  end
end