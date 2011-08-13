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
    before :each do
      @series = Factory(:series)
    end

    describe 'last_viewing' do
      it 'should return the watched viewing' do
        episode1 = Factory.build(:episode, :series => @series)
        episode2 = Factory.build(:episode, :series => @series)
        episode3 = Factory.build(:episode, :series => @series)
        viewing1 = Factory.build(:viewing, :episode => episode1, :viewed_at => 2.days.ago)
        viewing2 = Factory.build(:viewing, :episode => episode2)
        viewing3 = Factory.build(:viewing, :episode => episode3, :viewed_at => 1.days.ago)

        @series.last_viewing.should == viewing3
      end
    end
  end
end
