require 'test_helper'

class Admin::MaterialTypesTest < ActionDispatch::IntegrationTest
=begin
  def setup
    @valid_title = 'rainbowed chrome'
    @center_div_id = 'div#content-center'   
    @mat_type_1 = FactoryGirl.create(:material_type, id: 1, title: 'firebrick')   
  end 

  test "clicking create button twice with same title should only save once" do
    2.times do 
      visit admin_material_types_path
    
      within @center_div_id do 
        fill_in 'material_type_title', with: @valid_title
        click_button 'create_material_type'
        assert_equal MaterialType.where(title: @valid_title).count, 1
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
      fill_in 'material_type_title', with: @valid_title
      click_button 'update_material_type'
      assert_equal MaterialType.where(id: @mat_type_1).first.title, @valid_title
      assert_equal admin_material_types_path, current_path
    end
  end
   
  test "clicking delete button should delete mat type and all mat relations" do  
    visit edit_admin_material_type_path(@mat_type_1)
    
    within @center_div_id do
      click_button 'delete_material_type'  
      assert_equal MaterialType.where(title: 'firebrick').exists?, false
      assert_equal Material.where(material_type_id: 1).count, 0
      assert_equal admin_material_types_path, current_path
    end    
  end
=end
end