class Finish < ActiveRecord::Base
  has_many :material_finishes, :dependent => :destroy
  has_many :materials, :through => :material_finishes
  belongs_to :image, :polymorphic => true
  
  attr_accessible :title 

  validates_presence_of :title
  validates_uniqueness_of :title
  validates :title, :length => { :in => 3..40 }

end
