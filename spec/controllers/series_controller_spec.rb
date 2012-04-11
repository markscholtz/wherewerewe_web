require 'spec_helper'

describe SeriesController do
  describe 'GET "index"' do
    before :each do
      @user = FactoryGirl.create(:user)
      #@series1 = FactoryGirl.create(:series)
      #@series2 = FactoryGirl.create(:series)
      #@series3 = FactoryGirl.create(:series)
      #@episode1 = FactoryGirl.create(:episode, :series => @series1)
      #@episode2 = FactoryGirl.create(:episode, :series => @series1)
      #@viewing1 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode1, :series => @series1, :viewed_at => 3.days.ago)
      #@viewing2 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode2, :series => @series1)
      #@viewing3 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode1, :series => @series2, :viewed_at => 2.days.ago)
      #@viewing5 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode2, :series => @series3, :viewed_at => 6.days.ago)
    end

    it 'should be successful' do
      get 'index'
      response.should be_success
    end

    it 'should populate a series collection for the view' do
      get 'index'
      assigns[:user].should  == @user
      #assigns[:all_series].should  include(@series1, @series2, @series3)
    end
  end
end
