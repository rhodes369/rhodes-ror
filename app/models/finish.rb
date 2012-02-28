class Finish < ActiveRecord::Base
  has_one :finish
  has_many :material_finishes, :dependent => :destroy
  has_many :materials, :through => :material_finishes

  validates :title, presence: true
  validates_uniqueness_of :title    
end
