require 'spec_helper'

describe SeriesController do
  describe 'GET "index"' do
    before :each do
      @user         = FactoryGirl.create(:user)
      @fringe       = FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
      @boston_legal = FactoryGirl.create(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers')
    end

    it 'should be successful' do
      get 'index'
      response.should be_success
    end

    it 'should populate a list of series for the view' do
      get 'index'
      assigns[:series].should  == [@boston_legal, @fringe]
    end

    it 'should populate user for the view' do
      get 'index'
      assigns[:user].should  == @user
    end
  end
end
