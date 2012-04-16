require 'spec_helper'

feature 'User add viewing feature', %q{
  In order to keep track of series that I intend to watch
  As a user
  I want to add series to my viewing list
} do

  background do
    @user = FactoryGirl.create(:user)
    @fringe = FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
  end

  scenario 'Adding a series' do
    visit series_index_path
    click_button 'add to viewing list'
    page.should have_css(".flash_notice", :text => "Fringe has been added to your viewing list")
    page.should_not have_content 'add to viewing list'
    page.should have_content 'add to viewing list'
    save_and_open_page
    current_path.should == series_index_path
  end
end
