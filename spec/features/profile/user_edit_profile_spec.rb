require 'rails_helper'

RSpec.feature 'User changes profile information' do 

  given(:registered_user) { create(:user) }
  
    background do 
      given_the_user_visits_profile_edit_page
    end

    scenario "with valid information" do
      when_user_submits_form_with_valid_information 
      then_user_redirected_to_updated_profile 
    end

    scenario "with invalid information" do
      when_user_submits_form_with_invalid_information 
      then_user_needs_to_correct_information
    end


    def given_the_user_visits_profile_edit_page
      login_as(registered_user, scope: :user)
      @profile = create(:profile)

      visit posts_path 
      expect(page.current_path).to eq( posts_path)
      
      click_link 'Admin Page'
      expect(page.current_path).to eq( posts_manage_posts_path )

      click_link "Profile"
      expect(page.current_path).to eq( profile_path(@profile.id) )

      click_link "edit profile"
      expect(page.current_path).to eq( edit_profile_path(@profile.id))
    end

    def when_user_submits_form_with_valid_information
      fill_in "profile_first_name", with: "Peter"
      fill_in "profile_last_name", with: "alleee"
      fill_in "profile_blog_title", with: "New"
      fill_in "profile_about_me", with: 'ooooooo'
      click_button "Update Profile"
    end

    def when_user_submits_form_with_invalid_information
      fill_in "profile_first_name", with: "Peter"
      fill_in "profile_last_name", with: "alleee"
      fill_in "profile_blog_title", with: nil
      fill_in "profile_about_me", with: 'ooooooo'
      click_button "Update Profile"
    end

    def then_user_redirected_to_updated_profile 
      expect(page.current_path).to eq( profile_path(@profile.id) ) 
      expect(page).to have_content("Peter")
      expect(page).to have_content("alleee")
      expect(page).to have_content("New")
      expect(page).to have_content("ooooooo")
    end

    def then_user_needs_to_correct_information
      expect(page).to have_content("can't be blank")
    end



end