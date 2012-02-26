class Application < ActiveRecord::Base
  has_many :material_applications, :dependent => :destroy
  has_many :materials, :through => :material_finishes

  validates :title, presence: true
  validates_uniqueness_of :title  
end
