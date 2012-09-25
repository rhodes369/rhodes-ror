class Standard < ActiveRecord::Base
  has_many :standard_values

  def unit
    Unit.find(self.unit_id)
  end
end
