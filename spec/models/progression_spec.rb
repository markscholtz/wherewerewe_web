require 'spec_helper'

describe Progression do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:boston_legal) { FactoryGirl.create(:series,
                                           name: 'Boston Legal',
                                           overview: 'A Boston law firm ...') }
  # let!(:series) { FactoryGirl.create(:series_with_episodes) }

  describe 'validations' do
    let(:progression) { Progression.new }

    it 'should have a valid factory' do
      FactoryGirl.build(:progression).should be_valid
    end

    it 'should require a user' do
      progression.should_not be_valid
      progression.errors_on(:user).should_not be_blank
    end

    it 'should require a series' do
      progression.should_not be_valid
      progression.errors_on(:series).should_not be_blank
    end
  end

  describe 'derived attributes' do
    let(:progression) { FactoryGirl.build(:progression,
                                           user: user,
                                           series: boston_legal) }

    describe 'series attributes' do
      it 'should derive the series name from the series' do
        progression.series_name.should == 'Boston Legal'
      end

      it 'should derive the series overview from the series' do
        progression.series_overview.should == 'A Boston law firm ...'
      end

      it 'should derive the viewed state from the series' do
        progression.series_viewed?.should == false
      end
    end

    describe 'viewings' do
      let!(:season)   { FactoryGirl.create(:season, number: 1, series: boston_legal) }
      let!(:episode1) { FactoryGirl.create(:episode,
                                           number: 1,
                                           name: 'Episode 1',
                                           overview: 'Overview ...',
                                           series: boston_legal,
                                           season: season) }
      let!(:viewing1) { FactoryGirl.create(:viewing,
                                           user: user,
                                           series: boston_legal,
                                           season: season,
                                           episode: episode1,
                                           viewed_at: 1.day.ago) }

      describe 'last viewing attributes' do
        it "should derive the last viewing from the user's last viewing" do
          progression.last_viewing.should == viewing1
        end

        it 'should derive the last viewed season number from the last viewing' do
          progression.last_viewing_season_number.should == 1
        end

        it 'should derive the last viewed episode number from the last viewing' do
          progression.last_viewing_episode_number.should == 1
        end

        it 'should derive the last viewed episode name from the last viewing' do
          progression.last_viewing_episode_name.should == 'Episode 1'
        end

        it 'should derive the last viewed episode overview from the last viewing' do
          progression.last_viewing_episode_overview.should == 'Overview ...'
        end
      end

      describe 'next viewing attributes' do
        let!(:episode2) { FactoryGirl.create(:episode,
                                             number: 2,
                                             name: 'Episode 2',
                                             overview: 'Yet another overview ...',
                                             series: boston_legal,
                                             season: season) }
        let!(:viewing2) { FactoryGirl.create(:viewing,
                                             user: user,
                                             series: boston_legal,
                                             season: season,
                                             episode: episode2) }

        it "should derive the next viewing from the user's next viewing" do
          progression.next_viewing.should == viewing2
        end

        it 'should derive the next viewed season number from the next viewing' do
          progression.next_viewing_season_number.should == 1
        end

        it 'should derive the next viewed episode number from the next viewing' do
          progression.next_viewing_episode_number.should == 2
        end

        it 'should derive the next viewed episode name from the next viewing' do
          progression.next_viewing_episode_name.should == 'Episode 2'
        end

        it 'should derive the next viewed episode overview from the next viewing' do
          progression.next_viewing_episode_overview.should == 'Yet another overview ...'
        end
      end
    end
  end

  describe 'progression creation' do
    it 'should create one progression per series for a given user' do
      progressions = Progression.create_progressions user, [boston_legal]
      progressions.count.should == 1
      progressions.first.series_name.should == boston_legal.name
    end
  end
end
