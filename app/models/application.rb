class Application < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: true
  validates_uniqueness_of :title  
  
end
