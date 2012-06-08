require 'spec_helper'

feature 'User authentication feature', %q{
  In order to secure my account
  As a user
  I want to have my account authenticated
} do

  scenario 'Registering as a new user' do
    visit register_path

    fill_in 'email', :with => 'mark@example.com'
    fill_in 'password', :with => 'crypt1c'
    fill_in 'confirm password', :with => 'crypt1c'
    click_button 'register'

    current_path.should == viewings_path
    page.should have_content 'Account successfully created for mark@example.com'
  end

  scenario 'Registering with incorrect details' do
    visit register_path
    click_button 'register'
    current_path.should == register_path
    page.should have_content 'Invalid email or password'
  end
end
