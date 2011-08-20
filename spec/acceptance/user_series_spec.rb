require 'spec_helper'

feature 'Series', %q{
  In order to view the series that I am currently watching
  As a user
  I want to view the series page
} do

  background do
    @series1 = Factory(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
    @series2 = Factory(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers')
  end

  scenario 'Viewing the "currently watching" series' do
    visit series_index_path

    page.should have_content @series1.name
    page.should have_content @series1.overview

    page.should have_content @series2.name
    page.should have_content @series2.overview
  end
end
