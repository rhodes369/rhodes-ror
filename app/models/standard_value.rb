class StandardValue < ActiveRecord::Base
  belongs_to :material
  belongs_to :standard
  
  # #imperials is the imperials value
  
  def metrics
    # do the conversion
  end
end
