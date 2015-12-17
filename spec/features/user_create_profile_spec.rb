require 'rails_helper'



RSpec.feature "Blogger creates new profile" do 

  
  given(:registered_user) { create(:user) }
  given(:user_profile) { build(:profile, user_id: registered_user.id )}

  ## The user profile should be created just after the registration ;  
  ## Or after sign in if the user did not finish to create a new profile after the registration.  

  context "when finish registration succesfully" do 
    background do 
      given_the_user_visits_new_profile_page_after_registration
    end

    scenario "new profile is saved successfully" do
      when_the_user_fill_out_and_submits_form_with_correct_information 
      then_the_user_is_redirected_to_home_page 
    end

    scenario "new profile is not saved" do
      when_the_user_fill_out_and_submits_new_profile_with_incorrect_information
      new_profile_page_is_rendered_with_information_to_complete
    end
    
  end

  context "The user does not complete a new profile after registering" do 
    background do 
      given_the_user_visits_new_profile_page_after_registration
      logout(:user)
    end

  end

  def given_the_user_visits_new_profile_page_after_registration
    login_as(registered_user, scope: :user)
    visit new_profile_path
    expect( page.current_path ).to eq( new_profile_path )
  end

  def when_the_user_fill_out_and_submits_form_with_correct_information
    fill_in 'profile_first_name', with: user_profile.first_name
    fill_in 'profile_last_name', with: user_profile.last_name
    fill_in 'profile_blog_title', with: user_profile.blog_title
    attach_file 'profile_photo', "#{Rails.root}/spec/fixtures/profile_new_page.jpg"
    fill_in 'profile_about_me', with: user_profile.about_me
    click_button 'Create Profile'
  end

  def when_the_user_fill_out_and_submits_new_profile_with_incorrect_information
    fill_in 'profile_first_name', with: user_profile.first_name
    fill_in 'profile_last_name', with: nil 
    fill_in 'profile_blog_title', with: user_profile.blog_title
    attach_file 'profile_photo', "#{Rails.root}/spec/fixtures/profile_new_page.jpg"
    fill_in 'profile_about_me', with: user_profile.about_me
    click_button 'Create Profile'
  end

  def then_the_user_is_redirected_to_home_page 
    expect( page.current_path ).to eq( root_path )
  end

  def new_profile_page_is_rendered_with_information_to_complete
    expect( page.current_path ).to eq( '/profiles')
  end



end 