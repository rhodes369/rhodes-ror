class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :username, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username
  validates :username, :length => { :in => 3..20 }
  validates :password, :length => { :in => 7..20 }
  
end
