class Material < ActiveRecord::Base
  has_one :material_type
  
  validates :title, presence: true
  validates_uniqueness_of :title
end