class Image < ActiveRecord::Base
  
  belongs_to :material
  belongs_to :finish
  
  attr_accessible :material_id, :min_thickness, :image, :image_file_name, 
                  :image_content_type, :image_file_size
  
  # paperclip settings
  has_attached_file :image, 
         :styles => { :large => "527x527>", :thumb => "95x95#" },
         :path => ":rails_root/public/system/materials/:attachment/:id/:style/:filename",
         :url => "/system/materials/:attachment/:id/:style/:filename"
                                       
  validates_attachment :image, 
      :presence => true, 
      :content_type => { :content_type => ['image/jpeg', 'image/png', 'image/gif'] },
      :size => { :in => 0..10.megabytes }
    
  
  # set finish id                   
  def set_finish(finish_id = nil)
    return if finish_id.nil?    
    finish = Finish.find(finish_id)
       
    self.finish_id = finish_id
    self.save!  
  end
  
  
  # set min thickness                 
  def set_min_thickness(min_thickness = nil)
    return if min_thickness.nil?    

    self.min_thickness = min_thickness
    self.save!  
  end  
  
  # set all records that use finish_id to nil 
  def self.remove_image_finishes(finish_id)  
    image_finishes = self.where(finish_id: finish_id)
    image_finishes_count = image_finishes.count
    if image_finishes_count > 0
      image_finishes.each do |image|
        image.finish_id = nil
        image.save!
      end
    end     
    return image_finishes_count
  end  
  
end
