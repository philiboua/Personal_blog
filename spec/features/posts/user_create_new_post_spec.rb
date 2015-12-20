require 'rails_helper'

RSpec.feature "New user Post" do 

  context "when logged in" do 
    given(:authenticate_user) { create(:user) }

   background do 
      given_the_user_visit_new_post_page
    end

    scenario "creates new post successfully" do 
      when_user_submits_form_with_valid_information
      then_user_redirected_to_post_page
    end

    scenario "creates new post unsuccessfully" do 
      when_user_submits_form_with_invalid_information
      then_user_needs_to_correct_information
    end
  end

  def given_the_user_visit_new_post_page
    login_as(authenticate_user, scope: :user)
    profile = create(:profile)
    visit posts_path
    click_link('Blog Admin')
    expect( page.current_path).to eq( posts_manage_posts_path )
    click_link 'write a new post'
    expect( page.current_path).to eq( new_post_path )
  end

  def when_user_submits_form_with_valid_information
    fill_in 'post_title', with: 'abarddlksjfs'
    fill_in 'post_body', with: 'aldkjflskdjflksdjflkdsjf fdkjflksdjfdksj'
    click_button 'Create Post'
  end

  def when_user_submits_form_with_invalid_information
    fill_in 'post_title', with: nil
    fill_in 'post_body', with: 'aldkjflskdjflksdjflkdsjf fdkjflksdjfdksj'
    click_button 'Create Post'
  end

  def then_user_redirected_to_post_page
    expect(page.current_path).to eq( post_path(Post.last))
  end

  def then_user_needs_to_correct_information
    expect(page).to have_content("can't be blank")
  end
end