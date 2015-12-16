require 'rails_helper'

RSpec.feature "Blog registration workflow" do 

  given(:user) { build(:user) }
  given(:registered_user) { create(:user) }

  ## We are going to create a blog ; only one user will be registered in our database

  context "the blog has no user registered " do 

    background do
      given_the_user_visit_the_home_page
      when_user_clicks_on_create_your_blog
      then_user_is_redirected_to_registration_page 
    end 

    scenario "User successfully registered" do 
      when_user_fill_out_and_submits_signup_form_with_correct_information
      then_user_is_redirected_to_new_profile_page
    end 

    scenario "User unsuccessfully registered" do 
      when_user_fill_out_and_submits_signup_form_with_incorrect_information
      then_user_needs_to_correct_sign_up_form_information
    end 

  end

  context "the blog has one user registered" do 

    scenario "User is logged in" do 
      the_user_is_redirected_to_home_page
    end

    scenario "User is not logged in " do 
      the_user_is_redirected_to_sign_in_page
    end

  end

  ## Context: the blog has no user registered 

    #background to both scenarios

  def given_the_user_visit_the_home_page
    visit root_path
  end

  def when_user_clicks_on_create_your_blog
    click_link 'create your blog'
  end

  def then_user_is_redirected_to_registration_page
    expect( page.current_path ).to eq( new_user_registration_path )
  end

    # methods specific to scenario "User successfully registered"

  def when_user_fill_out_and_submits_signup_form_with_correct_information
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Start your blog'
  end

  def then_user_is_redirected_to_new_profile_page
    login_as(registered_user, :scope => :user)
    expect( page.current_path ).to eq( new_profile_path )
  end

    # methods specific to scenario "User unsuccessfully registered"

  def when_user_fill_out_and_submits_signup_form_with_incorrect_information
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'hello'
    fill_in 'user_password_confirmation', with: 'hello'
    click_button 'Start your blog'
  end

  def then_user_needs_to_correct_sign_up_form_information
    expect( page.current_path).to eq('/users')
  end

  ## Context: the blog has one user registered

    #Scenario User is logged in

  def the_user_is_redirected_to_home_page
    login_as(registered_user, :scope => :user)
    visit new_user_registration_path
    expect( page.current_path ).to eq( root_path )
  end

    #Scenario User is not logged in 

  def the_user_is_redirected_to_sign_in_page
    login_as(registered_user, :scope => :user)
    logout(:user)
    visit new_user_registration_path
    expect( page.current_path ).to eq( new_user_session_path )
  end



end