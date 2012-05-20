require 'spec_helper'

feature 'User search series feature', %q{
  In order to keep track of series that I intend to watch
  As a user
  I want to search for series that can be added to my viewing list
} do

  background do
    @user         = FactoryGirl.create(:user)
    @fringe       = FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
    @boston_legal = FactoryGirl.create(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers')
  end

  scenario 'Viewing all available series' do
    visit series_index_path

    page.should have_content @fringe.name
    page.should have_content @fringe.overview
    page.should have_content @boston_legal.name
    page.should have_content @boston_legal.overview
  end
end
