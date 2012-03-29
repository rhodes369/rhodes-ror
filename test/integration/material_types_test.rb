require 'test_helper'

class MaterialTypesTest < ActionDispatch::IntegrationTest
  
  test "left sidebar should link to edit page" do 
    mat_type = Factory(:material_type, title: 'firebrick')
  
    visit admin_material_types_url
  
    within 'div#content-left' do
      click_link 'firebrick'
      assert_equal edit_admin_material_type_path(mat_type), current_path
      edit_admin_material_type_path(mat_type)
    end 
  end 
 
  test "clicking delete button should delete mat type and all mat relations" do  
  
    mat_type_1 = Factory(:material_type, id: 1, title: 'firebrick')
    mat_type_2 = Factory(:material_type, id: 2, title: 'granite')
    
    mat_1 = Factory(:material, material_type_id: 1)
    mat_2 = Factory(:material, material_type_id: 1)
    mat_3 = Factory(:material, material_type_id: 2)
    
    visit edit_admin_material_type_path(mat_type_1)
    
    within 'div#content-center' do
      click_button 'delete'
      assert_equal MaterialType.where(title: 'firebrick').exists?, false
      assert_equal Material.where(material_type_id: 1).count, 0
    end    
  end 
end
