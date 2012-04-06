require 'test_helper'

class MaterialTest < ActiveSupport::TestCase

  def setup
    @long_count = 10 # used for doing massive tests at a time, keep low for speed testing
    @mat_type_1 = FactoryGirl.create(:material_type, id: 1)
    @mat_1 = FactoryGirl.create(:material, id: 1)
    @mat_2 = FactoryGirl.create(:material_loaded, id: 2)
  end
  
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  should ensure_length_of(:title).is_at_most(255)

  test "valid with all attributes" do     
    assert @mat_1.valid?, 'Material was valid' 
  end
  
  test "make sure slug gets generated on save" do
    assert_not_nil @mat_1.cached_slug
  end
  
  test "test with many random titles" do
    @long_count.times do
      FactoryGirl.create(:material)
      assert_equal @mat_1.valid?, true, 'Title not valid'
    end   
  end  
  
  test "test many instances setting all textareas with random info" do
    @long_count.times do
      lorem = Faker::Lorem.paragraph
      
      @mat_1.description = lorem
      @mat_1.specifications = lorem 
      @mat_1.technical_data = lorem
  
      assert @mat_1.valid?
    end
  end
  
  test "test that material_type_title() returns proper title if one exists" do
    correct_title = MaterialType.find(@mat_2.material_type_id).title
    assert_equal @mat_2.material_type_title, correct_title
  end  
  
  test "test that material_type_title() returns blank for views if none set" do
    assert_equal @mat_1.material_type_title, ''
  end
end

