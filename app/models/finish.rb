class Finish < ActiveRecord::Base
  has_many :material_finishes, :dependent => :destroy
  has_many :materials, :through => :material_finishes
  
  attr_accessible :title 
  
  validates :title, presence: true
  validates_uniqueness_of :title, :alert => 'Title must be unique'
  validates_length_of :title, :maximum => 255, :alert => 'Title can only be 255 characters long'
end
