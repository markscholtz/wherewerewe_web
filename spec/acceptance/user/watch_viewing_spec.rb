require 'spec_helper'

feature 'User watch viewing feature', %q{
  In order to keep track of series that I intend to watch
  As a user
  I want to watch series on my viewing list
} do

  background do
    @user = FactoryGirl.create(:user)
    @episode = FactoryGirl.create(:episode, :name => 'Cool episode')
    @v1 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode)
  end

  scenario 'watching the last unwatched episode' do
    visit viewings_path

    within('#last_viewing') do
      page.should have_content 'No previously watched episodes'
    end
    within('#next_viewing') do
      page.should have_button 'Watch'
      page.should have_content 'Cool episode'
    end

    click_button 'Watch'

    within('#last_viewing') do
      page.should have_content 'Cool episode'
    end
    within('#next_viewing') do
      page.should_not have_button 'Watch'
      page.should have_content 'No upcoming episodes'
    end

    current_path.should == viewings_path
  end
end
