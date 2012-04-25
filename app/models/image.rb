class Image < ActiveRecord::Base
  
  belongs_to :material
  has_one :finish
  
  attr_accessible :material_id, :image, :image_file_name, 
                  :image_content_type, :image_file_size
  
  # paperclip settings
  has_attached_file :image, 
         :styles => { :large => "527x527>", :thumb => "95x95#" },
         :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
         :url => "/system/:attachment/:id/:style/:filename"
                                       
  validates_attachment :image, 
      :presence => true, 
      :content_type => { :content_type => ['image/jpeg', 'image/png', 'image/gif'] },
      :size => { :in => 0..10.megabytes }
    
                      
  def set_finish_id(finish_id = nil)
    return if finish_id.nil?
    
    self.finish_id = finish_id
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
