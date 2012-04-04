class Pdf < ActiveRecord::Base
  
  # belongs_to :material
  
  # attr_accessible :pdf, :material_id, :pdf_file_name, :pdf_content_type, :pdf_file_size                

  # validates_attachment :pdf, :content_type => { :content_type => ['application/pdf'] },:size => { :in => 0..10.megabytes }   
end
