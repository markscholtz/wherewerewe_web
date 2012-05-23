require 'spec_helper'

describe SeriesController do
  describe 'GET "index"' do
    before :each do
      @user         = FactoryGirl.create(:user)
      @fringe       = FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
      @boston_legal = FactoryGirl.create(:series, :name => 'Boston Legal', :overview => 'Some funny lawyers')
    end

    it 'should be successful' do
      get :index
      response.should be_success
    end

    it 'should populate a list of series for the view' do
      get :index
      assigns[:series].should  == [@boston_legal, @fringe]
    end

    it 'should populate user for the view' do
      get :index
      assigns[:current_user].should  == @user
    end
  end

  describe 'GET "show"' do
    before :each do
      @user         = FactoryGirl.create(:user)
      @boston_legal = FactoryGirl.create(:series, :name => 'Boston Legal')
    end

    it 'should be successful' do
      get :show, :id => @boston_legal.id
      response.should be_success
    end

    it 'should set the series for the view' do
      get :show, :id => @boston_legal.id
      assigns[:series].should  == @boston_legal
    end

    it 'should populate the current user for the view' do
      get :show, :id => @boston_legal.id
      assigns[:current_user].should  == @user
    end
  end
end
