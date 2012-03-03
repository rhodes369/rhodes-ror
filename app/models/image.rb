class Image < ActiveRecord::Base
  
  UPLOAD_PATH = "images/uploads"
  
  belongs_to :material
  has_one :finish
  
  
  validates :orig_filename, presence: true
end
