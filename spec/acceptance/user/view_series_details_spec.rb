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
    @bl_s2 = FactoryGirl.create(:season, :number => 2, :series => @boston_legal)
    @bl_ep2 = FactoryGirl.create(:episode,
                                 :series => @boston_legal,
                                 :season => @bl_s1,
                                 :name => "Boston Legal - Episode 2",
                                 :number => 2)
    @bl_ep1 = FactoryGirl.create(:episode,
                                 :series => @boston_legal,
                                 :season => @bl_s1,
                                 :name => "Boston Legal - Episode 1",
                                 :number => 1)
    @bl_ep3 = FactoryGirl.create(:episode,
                                 :series => @boston_legal,
                                 :season => @bl_s2,
                                 :name => "Boston Legal - Episode 1, Season 2",
                                 :number => 1)
    @viewing1 = FactoryGirl.create(:viewing,
                                   :user => @user,
                                   :episode => @bl_ep1,
                                   :season => @bl_s1,
                                   :series => @boston_legal,
                                   :viewed_at => 3.days.ago)
    @viewing2 = FactoryGirl.create(:viewing,
                                   :user => @user,
                                   :episode => @bl_ep2,
                                   :season => @bl_s1,
                                   :series => @boston_legal)
  end

  scenario 'Navigating to the series details page' do
    visit viewings_path
    click_link 'Boston Legal'
    current_path.should == series_path(@boston_legal)
  end

  scenario 'Inspecting the series details page' do
    visit series_path(@boston_legal)
    page.should have_content @boston_legal.name
    within(:xpath, '//section[@id="season"][1]') do
      page.should have_content "Season #{@bl_s1.number}"
      within(:xpath, ".//ol//li[1]") do
        page.should have_content @bl_ep1.name
        page.should have_css 'section.watched'
      end
      within(:xpath, ".//ol//li[2]") do
        page.should have_content @bl_ep2.name
        page.should_not have_css 'section.watched'
      end
    end
    within(:xpath, '//section[@id="season"][2]') do
      page.should have_content "Season #{@bl_s2.number}"
    end
  end
end
