require 'test_helper'

class Application::Test < ActionDispatch::IntegrationTest
  
  def setup
  end

  test "bad routes should redirect to root" do    
    invalid_paths = %w(/materialz /admin/materialz /admin/materials/test12/edit/2)
    invalid_paths.each do |invalid_path|
      visit invalid_path
      assert_equal root_path, current_path
    end
  end
end