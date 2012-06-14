require 'spec_helper'

feature 'User authentication feature', %q{
  In order to secure my account
  As a user
  I want to have my account authenticated
} do

  scenario 'Signing up as a new user' do
    visit root_path
    click_link 'sign up'
    current_path.should == sign_up_path

    fill_in 'email', :with => 'mark@example.com'
    fill_in 'password', :with => 'crypt1c'
    fill_in 'confirm password', :with => 'crypt1c'
    click_button 'sign up'

    current_path.should == viewings_path
    page.should have_content 'Account successfully created for mark@example.com'
  end

  scenario 'Signing up with incorrect details' do
    visit root_path
    click_link 'sign up'

    click_button 'sign up'
    current_path.should == sign_up_path
    page.should have_content 'Invalid email or password'
  end

  scenario 'Log in' do
    FactoryGirl.create(:user, :email => 'mark@example.com', :password => 'crypt1c')

    visit log_in_path
    page.should have_content 'log in'

    fill_in 'email', :with => 'mark@example.com'
    fill_in 'password', :with => 'crypt1c'
    click_button 'log in'

    current_path.should == viewings_path
    page.should have_content 'log out'
  end

  scenario 'Log in attempt with incorrect details' do
    visit log_in_path
    click_button 'log in'
    current_path.should == log_in_path
    page.should have_content 'Invalid email or password'
  end
end
