require 'spec_helper'

describe SeriesController do
  describe 'GET "index"' do
    before :each do
      @series1 = Factory(:series)
      @series2 = Factory(:series)
      @series3 = Factory(:series)
    end

    it 'should be successful' do
      get 'index'
      response.should be_success
    end

    it 'should populate a series collection for the view' do
      get 'index'
      assigns[:all_series].should  include(@series1, @series2, @series3)
    end
  end
end
