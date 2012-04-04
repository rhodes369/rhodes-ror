class Pdf < ActiveRecord::Base
  
  belongs_to :material
  
  attr_accessible :orig_filename, :pdf
  
  validates_attachment_content_type :pdf, :content_type => ['application/pdf'], :allow_nil => true
  
end
