require 'spec_helper'

feature "Series", %q{
  In order to view the series that I am currently watching
  As a user
  I want to view the series page
} do

  background do
    @series = Factory(:series)
  end

  scenario "Series index" do
    visit series_index_path
    page.should have_content("Find me")
  end
end
