require 'spec_helper'

describe Viewing do
  describe 'validations' do
    before :each do
      @viewing = Factory(:viewing)
    end

    it 'should have a valid factory' do
      @viewing.should be_valid
    end

    it 'should require a episode_id' do
      @viewing.episode_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:episode_id).should_not be_blank
    end

    it 'should require a series_id' do
      @viewing.series_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:series_id).should_not be_blank
    end

    it 'should require a user_id' do
      @viewing.user_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:user_id).should_not be_blank
    end
  end

  describe 'associations' do
    before :each do
      @episode = Factory(:episode)
      @user = Factory(:user)
      @viewing = Factory(:viewing, :episode => @episode, :user => @user)
    end

    it "should be destroyed along with it's episode" do
      @episode.viewings.should include(@viewing)
      @episode.destroy
      Viewing.find_by_id(@viewing.id).should be_nil
    end

    it "should be destroyed along with it's user" do
      @user.viewings.should include(@viewing)
      @user.destroy
      User.find_by_id(@user.id).should be_nil
    end
  end

  describe 'scopes' do
    describe 'last_viewed' do
      before :each do
        @user1 = Factory(:user)
        @user2 = Factory(:user)
        @series1 = Factory(:series)
        @series2 = Factory(:series)
        @series3 = Factory(:series)
        @episode1 = Factory(:episode, :series => @series1)
        @episode2 = Factory(:episode, :series => @series1)
        @episode3 = Factory(:episode, :series => @series1)
        @episode4 = Factory(:episode, :series => @series2)
        @viewing1 = Factory(:viewing, :user => @user1, :episode => @episode1, :series => @series1, :viewed_at => 3.days.ago)
        @viewing2 = Factory(:viewing, :user => @user1, :episode => @episode2, :series => @series1)
        @viewing3 = Factory(:viewing, :user => @user1, :episode => @episode3, :series => @series1, :viewed_at => 2.days.ago)
        @viewing4 = Factory(:viewing, :user => @user2, :episode => @episode3, :series => @series1, :viewed_at => 5.days.ago)
        @viewing5 = Factory(:viewing, :user => @user1, :episode => @episode4, :series => @series2, :viewed_at => 6.days.ago)
        @viewing6 = Factory(:viewing, :user => @user2, :episode => @episode1, :series => @series2, :viewed_at => 1.days.ago)
        @viewing7 = Factory(:viewing, :user => @user2, :episode => @episode1, :series => @series3)
      end

      it 'should return the most recent viewing for the given arguments' do
        Viewing.last_viewed(user_id: @user2.id).first.should == @viewing6
        Viewing.last_viewed(episode_id: @episode3.id).first.should == @viewing3
        Viewing.last_viewed(series_id: @series1.id).first.should == @viewing3
        Viewing.last_viewed(series_id: @series3.id).first.should be_nil
        Viewing.last_viewed(user_id: @user1.id, series_id: @series2.id).first.should == @viewing5
      end
    end
  end
end
