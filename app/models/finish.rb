class Finish < ActiveRecord::Base
  has_many :material_finishes, :dependent => :destroy
  has_many :materials, :through => :material_finishes
  
  attr_accessible :title 
  
  validates :title, presence: true
  validates_uniqueness_of :title   

end
