require 'test_helper'

class MaterialTypeTest < ActiveSupport::TestCase
  
  def setup
    @long_count = 10 # used for doing massive tests at a time, keep low for speed testing
    @mat_type_1 = FactoryGirl.create(:material_type, id: 1)
    @mat_1 = FactoryGirl.create(:material, id: 1)
    @mat_2 = FactoryGirl.create(:material_loaded, id: 2)
  end
  
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  
  test "valid with all attributes" do     
    assert @mat_type_1.valid?, 'Material was valid' 
  end
  
  test "test with many random titles" do
    @long_count.times do
      @mat_type_1.title = Faker::Name.name
      assert_equal @mat_type_1.valid?, true, 'Title not valid'
    end   
  end    
end
