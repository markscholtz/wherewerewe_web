require 'spec_helper'

feature 'User Series', %q{
  In order to view the series that I am currently watching
  As a user
  I want to view my series page
} do

  background do
    @user = FactoryGirl.create(:user)

    @fringe       = FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
    @boston_legal = FactoryGirl.create(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers')

    @f_ep1 = FactoryGirl.create(:episode, :series => @fringe, :name => "Fringe - Episode 1")
    @f_ep2 = FactoryGirl.create(:episode, :series => @fringe, :name => "Fringe - Episode 2")
    @f_ep3 = FactoryGirl.create(:episode, :series => @fringe, :name => "Fringe - Episode 3")
    @bl_ep1 = FactoryGirl.create(:episode, :series => @boston_legal, :name => "Boston Legal - Episode 1")

    @viewing1 = FactoryGirl.create(:viewing, :user => @user, :episode => @f_ep1, :series => @fringe, :viewed_at => 3.days.ago)
    @viewing2 = FactoryGirl.create(:viewing, :user => @user, :episode => @f_ep2, :series => @fringe, :viewed_at => 1.days.ago)
    @viewing3 = FactoryGirl.create(:viewing, :user => @user, :episode => @f_ep3, :series => @fringe, :viewed_at => 2.days.ago)
    @viewing4 = FactoryGirl.create(:viewing, :user => @user, :episode => @bl_ep1, :series => @boston_legal)
  end

  scenario 'Viewing the "currently watching" series' do
    fringe = @user.series.first
    boston_legal = @user.series.second
    fringe_last = Viewing.last_viewed(user_id: @user.id, series_id: fringe.id)
    fringe_next = Viewing.next(@user.id, fringe.id)
    boston_legal_last = Viewing.last_viewed(user_id: @user.id, series_id: boston_legal.id)
    boston_legal_next = Viewing.next(@user.id, boston_legal.id)

    visit series_index_path

    # save_and_open_page
    page.should have_content fringe.name
    page.should have_content fringe.overview
    page.should have_content fringe_last.episode.name
    page.should have_content fringe_last.episode.overview
    page.should have_content 'No upcoming episodes'

    page.should have_content boston_legal.name
    page.should have_content boston_legal.overview
    page.should have_content 'No previously watched episodes'
    page.should have_content boston_legal_next.episode.name
    page.should have_content boston_legal_next.episode.overview
  end
end
