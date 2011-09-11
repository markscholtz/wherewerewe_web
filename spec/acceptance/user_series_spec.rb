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
    first_series = @user.series.first
    second_series = @user.series.second
    last_viewing = Viewing.last(user_id: @user.id, series_id: @user.series[0].id).first
    #next_viewing = Viewing.next(user_id: @user.id, series_id: @user.series[0].id).first

    visit series_index_path

    #save_and_open_page
    page.should have_content first_series.name
    page.should have_content first_series.overview
    page.should have_content last_viewing.episode.name
    page.should have_content last_viewing.episode.overview
    #page.should have_content next_viewing.episode.name
    #page.should have_content next_viewing.episode.overview

    page.should have_content second_series.name
    page.should have_content second_series.overview
  end
end
