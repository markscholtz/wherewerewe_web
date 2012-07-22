require 'spec_helper'

feature 'User add viewing feature', %q{
  In order to keep track of series that I intend to watch
  As a user
  I want to add series to my viewing list
} do

  let! (:user)   { FactoryGirl.create(:user) }
  let! (:fringe) { FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff') }
  let! (:f_s1)   { FactoryGirl.create(:season, :number => 1, :series => fringe) }
  let! (:f_ep1)  { FactoryGirl.create(:episode, :series => fringe, :season => f_s1, :name => "Fringe - Episode 1") }

  scenario 'Adding a series' do
    log_in user
    visit series_index_path
    click_button 'add to viewing list'
    page.should have_css(".notifications", :text => "Fringe has been added to your viewing list")
    page.should_not have_selector 'input'
    current_path.should == series_index_path
  end
end
