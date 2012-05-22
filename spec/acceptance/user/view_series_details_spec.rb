require 'spec_helper'

feature 'View series details feature', %q{
  In order to view details of a series that I am watching
  As a user
  I want to view the series's details page
} do

  background do
    @user = FactoryGirl.create(:user)
    @boston_legal = FactoryGirl.create(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers')
    @bl_s1 = FactoryGirl.create(:season, :number => 1, :series => @boston_legal)
    @bl_ep1 = FactoryGirl.create(:episode, :series => @boston_legal, :season => @bl_s1, :name => "Boston Legal - Episode 1")
    @viewing1 = FactoryGirl.create(:viewing, :user => @user, :episode => @bl_ep1, :season => @bl_s1, :series => @boston_legal, :viewed_at => 3.days.ago)
  end

  scenario 'Navigating to the series details page' do
    visit viewings_path
    click_link 'Boston Legal'
    current_path.should == series_path(@boston_legal)
  end

  scenario 'Inspecting the series details page' do
    visit series_path(@boston_legal)
    page.should have_content @boston_legal.name
    page.should have_content "Season #{@bl_s1.number}"
    page.should have_content @bl_ep1.name
  end
end
