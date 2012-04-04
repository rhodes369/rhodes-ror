class Pdf < ActiveRecord::Base
  
  belongs_to :material
  
  attr_accessible :orig_filename

  # has_attached_file :pdf, 
  #        :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  #        :url => "/system/:attachment/:id/:style/:filename"
  # 
  # validates_attachment_content_type :pdf, :content_type => ['application/pdf'], :allow_nil => true
  #  validates_attachment :pdf, content_type => ['application/pdf'] ,:size => { :in => 0..10.megabytes }
      
end
