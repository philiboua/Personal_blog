require 'rails_helper'

RSpec.feature 'User can delete a post' do 

  given(:registered_user) { create(:user) }
  
    background do 
      given_the_user_visits_the_admin_page
    end

    scenario "post deleted successfully" do
      when_user_deletes_a_post
      then_the_post_should_disapear_automatically_from_the_page
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


    def when_user_deletes_a_post
      click_link 'delete post'
    end

    def then_the_post_should_disapear_automatically_from_the_page
      expect(page).not_to have_content("#{@post.title}")
    end



end