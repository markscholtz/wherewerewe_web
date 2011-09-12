require 'spec_helper'

describe Episode do

  describe 'validations' do
    before :each do
      @episode = Factory(:episode)
    end

    it 'should have a valid factory' do
      Factory.build(:episode).should be_valid
    end

    describe 'tvdb_id' do
      it 'should require a tvdb_id' do
        @episode.tvdb_id = nil
        @episode.should_not be_valid
        @episode.errors_on(:tvdb_id).should_not be_blank
      end

      it 'should have a unique tvdb_id' do
        another_episode = Factory.build(:episode, :tvdb_id => @episode.tvdb_id)
        another_episode.should_not be_valid
        another_episode.errors_on(:tvdb_id).should_not be_blank
      end
    end

    it 'should require a name' do
      @episode.name = nil
      @episode.should_not be_valid
      @episode.errors_on(:name).should_not be_blank
    end

    it 'should require a overview' do
      @episode.overview = nil
      @episode.should_not be_valid
      @episode.errors_on(:overview).should_not be_blank
    end

    it 'should require a last_updated' do
      @episode.last_updated = nil
      @episode.should_not be_valid
      @episode.errors_on(:last_updated).should_not be_blank
    end

    it 'should require a series_id' do
      @episode.series_id = nil
      @episode.should_not be_valid
      @episode.errors_on(:series_id).should_not be_blank
    end

    it 'should require a season_id' do
      @episode.season_id = nil
      @episode.should_not be_valid
      @episode.errors_on(:season_id).should_not be_blank
    end

    describe 'number' do
      it 'should require a number' do
        @episode.number = nil
        @episode.should_not be_valid
        @episode.errors_on(:number).should_not be_blank
      end

      it 'should have a unique number scoped by series and season' do
        episode_1 = Factory.create(:episode, :series_id => 1, :season_id => 1, :number => 1)
        episode_2 = Factory.build(:episode, :series_id => 1, :season_id => 1, :number => 1)

        episode_2.should_not be_valid
        episode_2.errors_on(:number).should_not be_blank

        episode_2.season_id = 2
        episode_2.should be_valid
      end
    end

  end

end
