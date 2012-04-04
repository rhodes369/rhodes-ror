class Pdf < ActiveRecord::Base
  
  belongs_to :material
  
  attr_accessible :pdf, :material_id, :pdf_file_name, :pdf_content_type, :pdf_file_size                
              
  #validates_attachment_content_type :pdf, :content_type => ['application/pdf'], :allow_nil => true
  #validates_attachment :pdf, content_type => ['application/pdf'] ,:size => { :in => 0..10.megabytes }
  #validates_uniqueness_of :pdf_name, :scope => :material_id
  
  validates_attachment :pdf, :content_type => { :content_type => ['application/pdf'] },:size => { :in => 0..10.megabytes }   
end
