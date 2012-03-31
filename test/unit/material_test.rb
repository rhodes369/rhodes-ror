require 'test_helper'
require 'faker'

class MaterialTest < ActiveSupport::TestCase

  def setup
    @long_count = 50
    @mat_1 = Factory(:material, id: 1)
    2.times { Factory.build(:material, title: Faker::Name.name) } 
  end
  
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  #should validate_numericality_of(:material_type_id)
  

  test "valid with all attributes" do     
    assert @mat_1.valid?, 'Material was valid' 
  end
  
  test "test with many random titles" do
    @long_count.times do
      @mat_1.title = Faker::Name.name
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
  
  test "make sure slug gets generated on save" do
    @mat_1.save!
    assert_equal @mat_1.cached_slug, @mat_1.title 
  end
end
