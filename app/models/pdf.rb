class Pdf < ActiveRecord::Base
  
  attr_accessible :title
  
  validates_attachment_content_type :pdf, :content_type => ['application/pdf'], :allow_nil => true
  
end
