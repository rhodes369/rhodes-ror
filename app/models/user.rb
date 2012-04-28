class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # note this currently has no users controller since for now we are only
  # adding new users manually via console, hence no attr_accessible vars needed yet
  # attr_accessible :username, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username
  validates :username, :length => { :in => 3..20 }
  validates :password, :length => { :in => 6..20 }
end
