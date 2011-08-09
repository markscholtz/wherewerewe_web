require 'spec_helper'

describe "Series" do
  describe "GET /series" do
    it "should display all series available for watching" do
      visit series_index_path
      page.should have_content("Find me")
    end
  end
end
