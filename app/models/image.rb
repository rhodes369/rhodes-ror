class Image < ActiveRecord::Base
  has_one :material
  
  validates :orig_filename, presence: true
end
