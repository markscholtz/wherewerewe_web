require 'spec_helper'

describe SeriesController do
  describe 'GET "index"' do
    before :each do
      @user = Factory(:user)
      #@series1 = Factory(:series)
      #@series2 = Factory(:series)
      #@series3 = Factory(:series)
      #@episode1 = Factory(:episode, :series => @series1)
      #@episode2 = Factory(:episode, :series => @series1)
      #@viewing1 = Factory(:viewing, :user => @user, :episode => @episode1, :series => @series1, :viewed_at => 3.days.ago)
      #@viewing2 = Factory(:viewing, :user => @user, :episode => @episode2, :series => @series1)
      #@viewing3 = Factory(:viewing, :user => @user, :episode => @episode1, :series => @series2, :viewed_at => 2.days.ago)
      #@viewing5 = Factory(:viewing, :user => @user, :episode => @episode2, :series => @series3, :viewed_at => 6.days.ago)
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
