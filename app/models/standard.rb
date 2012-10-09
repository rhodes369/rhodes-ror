class Standard < ActiveRecord::Base
  has_many :standard_values

  validates_presence_of :unit_id
  validate {|standard| standard.unit_id < Unit::UNITS.length && standard.unit_id >= 0}
  
  def unit
    Unit.find(self.unit_id)
  end
  
  def to_s
    "#{code} #{description} #{unit.imperial}"
  end
end
