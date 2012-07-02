require 'spec_helper'

feature 'User search series feature', %q{
  In order to keep track of series that I intend to watch
  As a user
  I want to search for series that can be added to my viewing list
} do

  let! (:user)         { FactoryGirl.create(:user) }
  let! (:fringe)       { FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff') }
  let! (:boston_legal) { FactoryGirl.create(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers') }

  scenario 'Viewing all available series' do
    log_in user
    visit series_index_path

    page.should have_content fringe.name
    page.should have_content fringe.overview
    page.should have_content boston_legal.name
    page.should have_content boston_legal.overview
  end
end
