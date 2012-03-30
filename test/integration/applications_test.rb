require 'test_helper'

class ApplicationsTest < ActionDispatch::IntegrationTest

  def setup 
    @center_div_id = 'div#content-center'  
    @app_1 = Factory(:application, id: 1, title: 'interior')
    @app_2 = Factory(:application, id: 2, title: 'exterior')    

    2.times { Factory(:material_application, material_id: 2) }
    @mat_app_1 = Factory(:material_application, material_id: 3, application_id: 1)
    @mat_app_2 = Factory(:material_application, material_id: 3, application_id: 2)      
  end

  test "clicking create button twice with same title should only save once" do
    2.times do 
      visit admin_applications_path
    
      within @center_div_id do 
        fill_in 'application_title', with: 'space vacume'
        click_button 'create_application'
        assert_equal Application.where(title: 'space vacume').count, 1
      end
    end
    assert_equal admin_applications_path, current_path
  end


  test "clickng update button should save title" do
    visit edit_admin_application_path(@app_1)
    
    within @center_div_id do
      new_title = 'test 369'
      fill_in 'application_title', with: new_title
      click_button 'update_application'
      assert_equal Application.where(id: @app_1).first.title, new_title
      assert_equal admin_applications_path, current_path
    end
  end


  test "left sidebar links should link to edit page" do 
    visit admin_applications_path
  
    within 'div#content-left' do
      click_link @app_1.title
      assert_equal edit_admin_application_path(@app_1), current_path
    end 
  end

  test "clicking delete button should delete application and all mat_app relations" do  
    visit edit_admin_application_path(@app_1)
    
    within @center_div_id do
      click_button 'delete'  
      assert_equal Application.where(title: 'interior').exists?, false
      assert_equal MaterialApplication.where(application_id: 1).count, 0
      assert_equal admin_applications_path, current_path
    end  
  end 
end
