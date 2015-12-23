require 'rails_helper'

RSpec.feature 'User can delete a post' do 

  given(:registered_user) { create(:user) }
  
    background do 
      given_the_user_visits_apps_index_page
    end

    scenario "post deleted successfully" do
      when_user_deletes_an_app
      then_the_app_info_should_disapear_automatically_from_the_page
    end


    def given_the_user_visits_apps_index_page
      login_as(registered_user, scope: :user)
      @profile = create(:profile)
      @app = create(:app)

      visit posts_path 
      expect(page.current_path).to eq( posts_path)
      
      click_link 'Admin Page'
      expect(page.current_path).to eq( posts_manage_posts_path )

      click_link "Apps"
      expect(page.current_path).to eq( apps_my_apps_path )
    end


    def when_user_deletes_an_app
      click_link "Delete app"
    end

    def then_the_app_info_should_disapear_automatically_from_the_page
      expect(page).not_to have_content("#{@app.name}")
    end



end