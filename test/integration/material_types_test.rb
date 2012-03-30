require 'test_helper'

class MaterialTypesTest < ActionDispatch::IntegrationTest
  
  def setup
    @center_div_id = 'div#content-center'
    @mat_type_1 = Factory(:material_type, id: 1, title: 'firebrick')
    @mat_type_2 = Factory(:material_type, id: 2, title: 'granite')    

    2.times { Factory(:material, material_type_id: 1) }
    @mat_3 = Factory(:material, material_type_id: 2)      
  end

  test "clicking create button twice with same title should only save once" do
    2.times do 
      visit admin_material_types_path
    
      within @center_div_id do 
        fill_in 'material_type_title', with: 'bamboo'
        click_button 'create_material_type'
        assert_equal MaterialType.where(title: 'bamboo').count, 1
      end
    end
    assert_equal admin_material_types_path, current_path
  end

  test "left sidebar links should link to edit page" do 
    visit admin_material_types_url
  
    within 'div#content-left' do
      click_link @mat_type_1.title
      assert_equal edit_admin_material_type_path(@mat_type_1), current_path
    end 
  end 

  test "clickng update button should save title" do
    visit edit_admin_material_type_path(@mat_type_1)
    
    within @center_div_id do
      new_title = 'test 12'
      fill_in 'material_type_title', with: new_title
      click_button 'update_material_type'
      assert_equal MaterialType.where(id: @mat_type_1).first.title, new_title
      assert_equal admin_material_types_path, current_path
    end
  end
 
  test "clicking delete button should delete mat type and all mat relations" do  
    visit edit_admin_material_type_path(@mat_type_1)
    
    within @center_div_id do
      click_button 'delete'  
      assert_equal MaterialType.where(title: 'firebrick').exists?, false
      assert_equal Material.where(material_type_id: 1).count, 0
      assert_equal admin_material_types_path, current_path
    end    
  end 
end