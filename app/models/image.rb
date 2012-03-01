class Image < ActiveRecord::Base
  has_one  :image_finishes, :dependent => :destroy
  has_one  :finish, :through => :image_finishes
  has_one  :material
  
  validates :orig_filename, presence: true
end
