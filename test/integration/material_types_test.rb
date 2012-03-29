require 'test_helper'

class MaterialTypesTest < ActionDispatch::IntegrationTest
  
  def setup
    @mat_type_1 = Factory(:material_type, id: 1, title: 'firebrick')
    @mat_type_2 = Factory(:material_type, id: 2, title: 'granite')    

    2.times { Factory(:material, material_type_id: 1) }
    @mat_3 = Factory(:material, material_type_id: 2)       
  end
  
  test "left sidebar links should link to edit page" do 
    visit admin_material_types_url
  
    within 'div#content-left' do
      click_link 'firebrick'
      assert_equal edit_admin_material_type_path(@mat_type_1), current_path
    end 
  end 
 
  test "clickng update button should save title" do
    visit edit_admin_material_type_path(@mat_type_1)
    
    within 'div#content-center' do
      new_title = 'test369'
      fill_in 'material_type_title', with: new_title
      click_button 'update'
      assert_equal MaterialType.where(id: @mat_type_1).first.title, new_title
    end
  end
 
  test "clicking delete button should delete mat type and all mat relations" do  
    visit edit_admin_material_type_path(@mat_type_1)
    
    within 'div#content-center' do
      click_button 'delete'  
      assert_equal MaterialType.where(title: 'firebrick').exists?, false
      assert_equal Material.where(material_type_id: 1).count, 0
    end    
  end 
end