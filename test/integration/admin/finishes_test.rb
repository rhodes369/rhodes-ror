require 'test_helper'

class FinishesTest < ActionDispatch::IntegrationTest
  def setup 
    @center_div_id = 'div#content-center'  
    @valid_title = 'rainbowed chrome'
    
    @finish_1 = Factory(:finish, id: 1, title: 'split')
    @finish_2 = Factory(:finish, id: 2, title: 'pineapple')    

    2.times { Factory(:material_finish, material_id: 2) }
    @mat_finish_1 = Factory(:material_finish, material_id: 3, finish_id: 1)
    @mat_finish_2 = Factory(:material_finish, material_id: 4, finish_id: 1)
    
    @mat_1 = Factory(:material, id: 1)
    @mat_2 = Factory(:material, id: 2)
    
    @image_1 = Factory(:image, material_id: 1, finish_id: 1)
    @image_2 = Factory(:image, material_id: 2, finish_id: 1)    
  end

  test "clicking create button twice with same title should only save once" do
    2.times do 
      visit admin_finishes_path

      within @center_div_id do 
        fill_in 'finish_title', with: @valid_title
        click_button 'create_finish'
        assert_equal Finish.where(title: @valid_title).count, 1
      end
    end
    assert_equal admin_finishes_path, current_path
  end

  test "clickng update button should save title" do
    visit edit_admin_finish_path(@finish_1)

    within @center_div_id do
      fill_in 'finish_title', with: @valid_title
      click_button 'update_finish'
      assert_equal Finish.where(id: @finish_1).first.title, @valid_title
      assert_equal admin_finishes_path, current_path
    end
  end

  test "left sidebar links should link to edit page" do 
    visit admin_finishes_path

    within 'div#content-left' do
      click_link @finish_1.title
      assert_equal edit_admin_finish_path(@finish_1), current_path
    end 
  end

  test "clicking delete button should delete finish and all mat finish 
        and mat image relations" do 
         
    visit edit_admin_finish_path(@finish_1)
      
    within @center_div_id do
      click_button 'delete_finish'  
      assert_equal Finish.where(title: @finish_1.title).exists?, false
      assert_equal MaterialFinish.where(finish_id: 1).count, 0
      assert_equal Image.where(finish_id: 1).count, 0
      assert_equal admin_finishes_path, current_path
    end  
  end 
end
