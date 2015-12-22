require 'rails_helper'

RSpec.feature 'User can edit a post' do 

  given(:registered_user) { create(:user) }
  
    background do 
      given_the_user_visits_the_admin_page
    end

    context "with valid information " do 
      scenario "post edit successfully" do
        when_user_edit_a_post_with_correct_info
        then_user_is_redirected_to_updated_post
      end
    end

    context "with invalid information " do 
      scenario "post edit unsuccessfully" do 
        when_user_edit_a_post_with_incorrect_info
        then_user_has_to_correct_missing_information
      end

    end
    scenario "post deleted successfully" do
    end


    def given_the_user_visits_the_admin_page
      login_as(registered_user, scope: :user)
      @profile = create(:profile)
      @post = create(:post)

      visit posts_path 
      expect(page.current_path).to eq( posts_path)
      
      click_link 'Admin Page'
      expect(page.current_path).to eq( posts_manage_posts_path )
    end

    def when_user_edit_a_post_with_correct_info
      click_link 'edit post'
      expect(page.current_path).to eq(edit_post_path(@post))
      fill_in 'post_title', with: 'Just want to change the title'
      fill_in 'post_body', with: 'Another story of my developer life lol'
      click_button 'Update Post'
    end

    def then_user_is_redirected_to_updated_post
      expect(page.current_path).to eq( post_path(@post))
      expect(page).to have_content('Just want to change the title')
      expect(page).to have_content('Another story of my developer life lol')
    end

    def when_user_edit_a_post_with_incorrect_info
      click_link 'edit post'
      expect(page.current_path).to eq(edit_post_path(@post))
      fill_in 'post_title', with: nil
      fill_in 'post_body', with: 'Another story of my developer life lol'
      click_button 'Update Post'
    end

    def then_user_has_to_correct_missing_information
      expect(page.current_path).to eq(post_path(@post))
      expect(page).to have_content("can't be blank")
    end
end