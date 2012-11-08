class Finish < ActiveRecord::Base
  belongs_to :image, :polymorphic => true
  
  attr_accessible :title 

  validates_presence_of :title
  validates_uniqueness_of :title
  validates :title, :length => { :in => 3..40 }

end
