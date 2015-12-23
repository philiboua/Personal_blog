require 'rails_helper'

RSpec.feature 'User can show a new app' do 

  given(:registered_user) { create(:user) }
  
    background do 
      given_the_user_visits_new_app_page
    end

    scenario "with valid information" do
      when_user_submits_form_with_valid_information 
      then_user_redirected_to_apps_index_page
    end

    scenario "with invalid information" do
      when_user_submits_form_with_invalid_information 
      then_user_needs_to_correct_information
    end


    def given_the_user_visits_new_app_page
      login_as(registered_user, scope: :user)
      profile = create(:profile)

      visit posts_path 
      expect(page.current_path).to eq( posts_path)
      
      click_link 'Admin Page'
      expect(page.current_path).to eq( posts_manage_posts_path )

      click_link "Apps"
      expect(page.current_path).to eq( apps_my_apps_path )

      click_link "New app"
      expect(page.current_path).to eq( new_app_path )
    end

    def when_user_submits_form_with_valid_information
      fill_in "app_name", with: "Bloccit"
      fill_in "app_content", with: "A reddit clone..."
      fill_in "app_website", with: "#{Faker::Internet.url}"
      click_button "Create App"
    end

    def when_user_submits_form_with_invalid_information
      fill_in "app_name", with: "Bloccit"
      fill_in "app_content", with: "A reddit clone..."
      fill_in "app_website", with: nil
      click_button "Create App"
    end

    def then_user_redirected_to_apps_index_page 
      expect(page.current_path).to eq( apps_path ) 
    end

    def then_user_needs_to_correct_information
      expect(page).to have_content("can't be blank")
    end



end