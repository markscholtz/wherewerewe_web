require 'spec_helper'

describe Series do
  describe 'validations' do
    before :each do
      @series = Factory(:series)
    end

    it 'should have a valid factory' do
      @series.should be_valid
    end

    it 'should require a tvdb_id' do
      @series.tvdb_id = nil
      @series.should_not be_valid
      @series.errors_on(:tvdb_id).should_not be_blank
    end

    it 'should have a unique tvdb_id' do
      another_series = Factory.build(:series, :tvdb_id => @series.tvdb_id)
      another_series.should_not be_valid
      another_series.errors_on(:tvdb_id).should_not be_blank
    end

    it 'should require a name' do
      @series.name = nil
      @series.should_not be_valid
      @series.errors_on(:name).should_not be_blank
    end

    it 'should require a overview' do
      @series.overview = nil
      @series.should_not be_valid
      @series.errors_on(:overview).should_not be_blank
    end

    it 'should require a last_updated' do
      @series.last_updated = nil
      @series.should_not be_valid
      @series.errors_on(:last_updated).should_not be_blank
    end
  end

  describe 'scopes' do
    describe 'viewed_by_user' do
      before :each do
        @user1 = Factory(:user)
        @user2 = Factory(:user)
        @series1 = Factory(:series)
        @episode1 = Factory(:episode, :series => @series1)
        @viewing1 = Factory(:viewing, :user => @user1, :episode => @episode1, :series => @series1, :viewed_at => 3.days.ago)
        @viewing2 = Factory(:viewing, :user => @user1, :episode => @episode1, :series => @series1)
        @viewing3 = Factory(:viewing, :user => @user2, :episode => @episode1, :series => @series1)
      end

      it 'should return true if the series has any episodes that have been viewed by the user' do
        Series.viewed_by_user(@user1.id).should == [@series1]
        Series.viewed_by_user(@user2.id).should be_empty
      end
    end
  end

  describe 'viewed?' do
    before :each do
      @user = Factory(:user)
      @series = Factory(:series)
      @episode = Factory(:episode, :series => @series)
      @viewing = Factory(:viewing, :user => @user, :episode => @episode, :series => @series, :viewed_at => 3.days.ago)
    end

    it 'should return true if the user has viewed any episodes' do
      @series.viewed?(@user.id).should be_true
    end

    it 'should return false if the user has not viewed any episodes' do
      @viewing.viewed_at = nil
      @viewing.save
      @series.viewed?(@user.id).should be_false
    end
  end
end
