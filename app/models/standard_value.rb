class StandardValue < ActiveRecord::Base
  belongs_to :material
  belongs_to :standard
  
  validates_presence_of :material
  validates_associated :material
  validates_presence_of :standard
  validates_associated :standard
  
  validates_numericality_of :imperials
  # #imperials is the imperials value
  
  def metrics
    standard.unit.convert_to_metric imperials
  end
end
