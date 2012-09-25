require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  
  def setup
    # @unit = Unit.find_by_imperial("lbs/ft3")
  end
  
  def test_find
    i = rand(Unit::UNITS.size)
    assert_equal Unit.find(i).imperial, Unit.new(Unit::UNITS[i]).imperial
  end
  
  def test_all
    all = Unit.all
    assert_equal all.size, Unit::UNITS.size
    assert_equal Unit::UNITS.map{|u| u[:imperial]}, all.map(&:imperial)
  end
  
  def test_find_by_imperial
    i = rand(Unit::UNITS.size)
    imp = Unit::UNITS[i][:imperial]
    assert_equal imp, Unit.find_by_imperial(imp).imperial
  end
  
  def test_convert_temp
    temp_unit = Unit.find_by_imperial("F")
    assert_equal 0, temp_unit.convert_to_celsius(32)
    assert_equal 0, temp_unit.convert_to_metric(32)

    assert_equal 100, temp_unit.convert_to_celsius(212).to_i
    assert_equal 100, temp_unit.convert_to_metric(212).to_i
  end
end
