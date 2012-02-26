class Material < ActiveRecord::Base
  has_one :material_type
  has_many :material_finishes
  has_many :finishes, :through => :material_finishes
  
  validates :title, presence: true
  validates_uniqueness_of :title
end
