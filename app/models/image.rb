class Image < ActiveRecord::Base
  belongs_to :material #, :through => material_images
  
  validates :orig_filename, presence: true
end
