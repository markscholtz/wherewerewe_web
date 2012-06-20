require 'spec_helper'

describe Episode do

  describe 'validations' do
    it 'should have a valid factory' do
      FactoryGirl.build(:episode).should be_valid
    end

    it 'should have a unique tvdb_id' do
      episode = FactoryGirl.create(:episode)
      another_episode = FactoryGirl.build(:episode, :tvdb_id => episode.tvdb_id)
      another_episode.should_not be_valid
      another_episode.errors_on(:tvdb_id).should_not be_blank
    end

    it 'should have a unique number scoped by series and season' do
      episode_1 = FactoryGirl.create(:episode, :series_id => 1, :season_id => 1, :number => 1)
      episode_2 = FactoryGirl.build(:episode, :series_id => 1, :season_id => 1, :number => 1)

      episode_2.should_not be_valid
      episode_2.errors_on(:number).should_not be_blank

      episode_2.season_id = 2
      episode_2.should be_valid
    end
  end

  context 'checking a watched status of an episode' do
    before :each do
      @user = FactoryGirl.create(:user)
      @episode1 = FactoryGirl.create(:episode)
      @episode2 = FactoryGirl.create(:episode)
      @episode3 = FactoryGirl.create(:episode)
      @viewing1 = FactoryGirl.create(:viewing, :user => @user, :episode_id => @episode1.id, :viewed_at => 1.day.ago)
      @viewing2 = FactoryGirl.create(:viewing, :user => @user, :episode_id => @episode2.id)
    end

    describe 'given a user' do
      it 'should return whether the episode has been watched or not' do
        @episode1.watched?(@user).should be_true
        @episode2.watched?(@user).should be_false
        @episode3.watched?(@user).should be_false
      end
    end
  end
end
