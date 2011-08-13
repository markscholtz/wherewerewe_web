require 'spec_helper'

describe Episode do
  describe 'validations' do
    before :each do
      @episode = Factory(:episode)
    end

    it 'should have a valid factory' do
      Factory.build(:episode).should be_valid
    end

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
      @episode.last_updated = nil
      @episode.should_not be_valid
      @episode.errors_on(:last_updated).should_not be_blank
    end

    it 'should require a season_id' do
      @episode.last_updated = nil
      @episode.should_not be_valid
      @episode.errors_on(:last_updated).should_not be_blank
    end
  end
end
