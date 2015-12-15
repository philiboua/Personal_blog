require 'rails_helper'

RSpec.feature "User registration" do 

  let(:user) { build(:user) }
  let(:registered_user) { create(:user) }

  before(:each) do
    given_the_home_page_is_open
    when_user_clicks_on_create_your_blog
    then_user_is_redirected_to_registration_page 
  end 

  scenario "User successfully registered" do 
    when_user_fills_in_signup_form_with_correct_information
    then_user_is_redirected_to_new_profile_page
  end 

  scenario "User unsuccessfully registered" do 
    when_user_fills_in_signup_form_with_incorrect_information
    then_user_needs_to_correct_sign_up_form_information
  end 

  #background to both scenarios

  def given_the_home_page_is_open
    visit root_path
  end

  def when_user_clicks_on_create_your_blog
    click_link 'create your blog'
  end

  def then_user_is_redirected_to_registration_page
    expect( page.current_path ).to eq( new_user_registration_path )
  end

  # methods specific to scenario "User successfully registered"

  def when_user_fills_in_signup_form_with_correct_information
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

  def when_user_fills_in_signup_form_with_incorrect_information
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'hello'
    fill_in 'user_password_confirmation', with: 'hello'
    click_button 'Start your blog'
  end

  def then_user_needs_to_correct_sign_up_form_information
    expect( page.current_path).to eq('/users')
  end


end