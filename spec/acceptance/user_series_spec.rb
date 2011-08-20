require 'spec_helper'

feature 'User Series', %q{
  In order to view the series that I am currently watching
  As a user
  I want to view my series page
} do

  background do
    @user = Factory(:user)
    @series1 = Factory(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
    @series2 = Factory(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers')
    @episode1 = Factory(:episode, :series => @series1, :name => "Episode 1")
    @episode2 = Factory(:episode, :series => @series1, :name => "Episode 2")
    @episode3 = Factory(:episode, :series => @series2, :name => "Episode 3")
    @viewing1 = Factory(:viewing, :user => @user, :episode => @episode1, :series => @series1, :viewed_at => 3.days.ago)
    @viewing2 = Factory(:viewing, :user => @user, :episode => @episode2, :series => @series1, :viewed_at => 1.days.ago)
    @viewing3 = Factory(:viewing, :user => @user, :episode => @episode3, :series => @series1, :viewed_at => 2.days.ago)
    @viewing4 = Factory(:viewing, :user => @user, :episode => @episode3, :series => @series2)
  end

  scenario 'Viewing the "currently watching" series' do
    visit series_index_path

    #save_and_open_page
    page.should have_content @user.series[0].name
    page.should have_content @user.series[0].overview
    page.should have_content Viewing.last_viewed(user_id: @user.id, series_id: @user.series[0].id).first.episode.name

    page.should have_content @user.series[1].name
    page.should have_content @user.series[1].overview
    page.should_not have_content Viewing.last_viewed(user_id: @user.id, series_id: @user.series[1].id).first.episode.name
  end
end
