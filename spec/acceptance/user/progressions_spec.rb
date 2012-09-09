require 'spec_helper'

feature 'User progressions feature', %q{
  As a user
  In order to view series that I intend to watch and series that I am currently watching
  I want to view my progressions page
} do

  let(:user) { FactoryGirl.create(:user) }

  let(:fringe)       { FactoryGirl.create(:series, name: 'Fringe',       overview: 'Supernatural stuff') }
  let(:boston_legal) { FactoryGirl.create(:series, name: 'Boston Legal', overview: 'Some funny lawyers') }

  let(:f_s0)  { FactoryGirl.create(:season, series: fringe,       number: 0) }
  let(:f_s1)  { FactoryGirl.create(:season, series: fringe,       number: 1) }
  let(:bl_s1) { FactoryGirl.create(:season, series: boston_legal, number: 1) }

  let(:f_ep0)  { FactoryGirl.create(:episode, number: 1, series: fringe,       name: 'Fringe - Special',         overview: 'Special 1',  season: f_s0) }
  let(:f_ep1)  { FactoryGirl.create(:episode, number: 1, series: fringe,       name: 'Fringe - Ep 1',       overview: 'Overview 1', season: f_s1) }
  let(:f_ep2)  { FactoryGirl.create(:episode, number: 2, series: fringe,       name: 'Fringe - Ep 2',       overview: 'Overview 2', season: f_s1) }
  let(:f_ep3)  { FactoryGirl.create(:episode, number: 3, series: fringe,       name: 'Fringe - Ep 3',       overview: 'Overview 3', season: f_s1) }
  let(:bl_ep1) { FactoryGirl.create(:episode, number: 1, series: boston_legal, name: 'Boston Legal - Ep 1', overview: 'Overview 4', season: bl_s1) }

  let!(:viewing0) { FactoryGirl.create(:viewing, user: user, episode: f_ep0,  season: f_s0,  series: fringe) }
  let!(:viewing1) { FactoryGirl.create(:viewing, user: user, episode: f_ep1,  season: f_s1,  series: fringe, viewed_at: 3.days.ago) }
  let!(:viewing2) { FactoryGirl.create(:viewing, user: user, episode: f_ep2,  season: f_s1,  series: fringe, viewed_at: 1.days.ago) }
  let!(:viewing3) { FactoryGirl.create(:viewing, user: user, episode: f_ep3,  season: f_s1,  series: fringe, viewed_at: 2.days.ago) }
  let!(:viewing4) { FactoryGirl.create(:viewing, user: user, episode: bl_ep1, season: bl_s1, series: boston_legal) }

  scenario 'Viewing my series list' do
    fringe_last = user.last_viewing(fringe.id)
    fringe_next = user.next_viewing(fringe.id)
    boston_legal_last = user.last_viewing(boston_legal.id)
    boston_legal_next = user.next_viewing(boston_legal.id)

    log_in user
    visit progressions_path

    within(:xpath, "//section[@id='progression'][1]") do
      expect(page).to have_content('Fringe')
      expect(page).to have_content('Supernatural stuff')
      within('#last_viewing') do
        expect(page).to have_content('Season 1')
        expect(page).to have_content('Episode 2')
        expect(page).to have_content('Fringe - Ep 2')
        expect(page).to have_content('Overview 2')
      end
      within('#next_viewing') do
        expect(page).to have_content('No upcoming episodes')
      end
    end

    within(:xpath, "//section[@id='progression'][2]") do
      expect(page).to have_content('Boston Legal')
      expect(page).to have_content('Some funny lawyers')
      within('#last_viewing') do
        expect(page).to have_content('No previously watched episodes')
      end
      within('#next_viewing') do
        expect(page).to have_content('Season 1')
        expect(page).to have_content('Episode 1')
        expect(page).to have_content('Boston Legal - Ep 1')
        expect(page).to have_content('Overview 4')
      end
    end

    click_button 'Watch'

    expect(page).to_not have_content 'No previously watched episodes'
  end
end
