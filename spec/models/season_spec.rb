require 'spec_helper'

describe Season do
  describe 'validations' do
    before :each do
      @season = Factory(:season)
    end

    it 'should have a valid factory' do
      Factory.build(:season).should be_valid
    end

    it 'should require a tvdb_id' do
      @season.tvdb_id = nil
      @season.should_not be_valid
      @season.errors_on(:tvdb_id).should_not be_blank
    end

    it 'should have a unique tvdb_id' do
      another_season = Factory.build(:season, :tvdb_id => @season.tvdb_id)
      another_season.should_not be_valid
      another_season.errors_on(:tvdb_id).should_not be_blank
    end

    it 'should require a number' do
      @season.number = nil
      @season.should_not be_valid
      @season.errors_on(:number).should_not be_blank
    end

    it 'should require a series' do
      @season.series = nil
      @season.should_not be_valid
      @season.errors_on(:series).should_not be_blank
    end
  end
end
