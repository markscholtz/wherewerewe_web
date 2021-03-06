require 'spec_helper'

describe Season do

  describe 'validations' do
    it 'should have a valid factory' do
      FactoryGirl.build(:season).should be_valid
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

end
