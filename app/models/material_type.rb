class MaterialType < ActiveRecord::Base
  belongs_to :material
  
  validates :title, presence: true
  validates_uniqueness_of :title

  attr_accessible :title
end
