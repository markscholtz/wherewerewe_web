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
end
