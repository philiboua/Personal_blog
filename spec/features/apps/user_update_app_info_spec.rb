require 'rails_helper'

RSpec.feature 'User changes profile information' do 

  given(:registered_user) { create(:user) }
  
    background do 
      given_the_user_visits_app_edit_page
    end

    scenario "with valid information" do
      when_user_submits_form_with_valid_information 
      then_user_redirected_to_app_index_page 
    end

    scenario "with invalid information" do
      when_user_submits_form_with_invalid_information 
      then_user_needs_to_correct_information
    end


    def  given_the_user_visits_app_edit_page
      login_as(registered_user, scope: :user)
      @profile = create(:profile)
      @app = create(:app)
      
      visit posts_path 
      expect(page.current_path).to eq( posts_path)
      
      click_link 'Admin Page'
      expect(page.current_path).to eq( posts_manage_posts_path )

      click_link "Apps"
      expect(page.current_path).to eq( apps_my_apps_path )

      click_link "Edit app info"
      expect(page.current_path).to eq( edit_app_path(@app.id) )
    end

    def when_user_submits_form_with_valid_information
      fill_in "app_name", with: "Akwajob"
      fill_in "app_content", with: "A new job board"
      fill_in "app_website", with: "#{Faker::Internet.url}"
      click_button "Update App"
    end

    def when_user_submits_form_with_invalid_information
      fill_in "app_name", with: nil
      fill_in "app_content", with: "A new job board"
      fill_in "app_website", with: "#{Faker::Internet.url}"
      click_button "Update App"
    end

    def then_user_redirected_to_app_index_page 
      expect(page.current_path).to eq( apps_path ) 
      expect(page).to have_content("Akwajob")
      expect(page).to have_content("A new job board")
    end

    def then_user_needs_to_correct_information
      expect(page).to have_content("can't be blank")
    end



end