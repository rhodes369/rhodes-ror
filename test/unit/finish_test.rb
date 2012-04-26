require 'test_helper'

class FinishTest < ActiveSupport::TestCase
  
  def setup
    @finish_1 = FactoryGirl.create(:finish, title: 'test')
  end  
  
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  should ensure_length_of(:title).is_at_least(3)
  should ensure_length_of(:title).is_at_most(40)
  
end
