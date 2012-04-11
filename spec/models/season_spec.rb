require 'spec_helper'

describe Season do

  describe 'validations' do
    before :each do
      @season = FactoryGirl.create(:season)
    end

    it 'should have a valid factory' do
      FactoryGirl.build(:season).should be_valid
    end

    describe 'tvdb_id' do
      it 'should require a tvdb_id' do
        @season.tvdb_id = nil
        @season.should_not be_valid
        @season.errors_on(:tvdb_id).should_not be_blank
      end

      it 'should have a unique tvdb_id' do
        another_season = FactoryGirl.build(:season, :tvdb_id => @season.tvdb_id)
        another_season.should_not be_valid
        another_season.errors_on(:tvdb_id).should_not be_blank
      end
    end

    describe 'number' do
      it 'should require a number' do
        @season.number = nil
        @season.should_not be_valid
        @season.errors_on(:number).should_not be_blank
      end

      it 'should have a unique number scoped by series' do
        season_1 = FactoryGirl.create(:season, :series_id => 1, :number => 1)
        season_2 = FactoryGirl.build(:season, :series_id => 1, :number => 1)

        season_2.should_not be_valid
        season_2.errors_on(:number).should_not be_blank

        season_2.series_id = 2
        season_2.should be_valid
      end
    end

    it 'should require a series' do
      @season.series_id = nil
      @season.should_not be_valid
      @season.errors_on(:series_id).should_not be_blank
    end
  end

end
