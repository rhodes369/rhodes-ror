class Image < ActiveRecord::Base
  
  belongs_to :material
  has_one :finish
  
  attr_accessible :material_id, :image, :image_file_name, 
                  :image_content_type, :image_file_size
  
  has_attached_file :image, :styles => { :large => "529x529>",  
                    :thumb => "95x95#" }

  validates_uniqueness_of :image_file_name, :scope => :material_id 
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, 
                        :content_type => ['image/jpeg', 'image/png']
   
end
