require 'spec_helper'

describe SeriesFinder do
  it 'should save a found series' do
    VCR.use_cassette('west_wing') do
      SeriesFinder.find('the west wing')
      tww = Series.first
      expect(tww.name).to eq('The West Wing')
      expect(tww.seasons).to_not be_empty
      expect(tww.episodes).to_not be_empty

      SeriesFinder.find('the west wing')
      expect(Series.find_all_by_name('the west wing').count).to eq(1)
    end
  end

  pending 'should search the local database before thetvdb.com' do

  end

  pending 'should not save a series if the tvdb_id has already been taken' do

  end

  pending 'should replace blank strings with n/a' do

  end

  pending 'should log to its own logger' do

  end

  pending 'should rescue from errors and rollback any changes made' do

  end
end
