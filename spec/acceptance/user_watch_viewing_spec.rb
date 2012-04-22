require 'spec_helper'

feature 'User watch viewing feature', %q{
  In order to keep track of series that I intend to watch
  As a user
  I want to watch series on my viewing list
} do

  background do
    @user   = FactoryGirl.create(:user)
    # @fringe = FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
    # @f_s1   = FactoryGirl.create(:season, :number => 1, :series => @fringe)
    # @f_ep1  = FactoryGirl.create(:episode, :series => @fringe, :season => @f_s1, :name => "Fringe - Episode 1")
    @v1 = FactoryGirl.create(:viewing, :user => @user)
  end

  scenario 'Watching an episode' do
    visit viewings_path
    # save_and_open_page
    click_button 'Watch'
    page.should_not have_selector 'input'
    page.should have_content 'No upcoming episodes'
    current_path.should == viewings_path
  end
end
