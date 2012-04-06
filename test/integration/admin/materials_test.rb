require 'test_helper'

class MaterialsTest < ActionDispatch::IntegrationTest
  
  def setup
    @mat_type_1 = Factory(:material_type, id: 1)
    @mat_1 = Factory(:material, id: 1)      
  end

  test "updating mat title should set save old & new slugged urls" do
    orig_title = @mat_1.title
    test_slug = 'test555555'
    
    visit edit_admin_material_path(@mat_1)
  
    fill_in 'material_title', with: test_slug
    click_button 'update_material'
      
    # make sure we get redirected with latest title/slug
    assert_equal edit_admin_material_path(test_slug), current_path
      
    # now test saved cached slug
    visit edit_admin_material_path(orig_title)
    assert_equal edit_admin_material_path(orig_title), current_path
    
    # test bad slug redirect
    bad_slug = "#{test_slug}-9993"       
    get edit_admin_material_path(bad_slug) 
    assert_response :redirect
    assert_redirected_to admin_materials_path   
  end
end