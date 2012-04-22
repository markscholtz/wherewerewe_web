require 'spec_helper'

describe ViewingsController do
  describe 'GET "index"' do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it 'should be successful' do
      get 'index'
      response.should be_success
    end

    it 'should populate a user for the view' do
      get 'index'
      assigns[:user].should  == @user
    end
  end

  describe "POST 'create'" do
    before :each do
      @user = FactoryGirl.create(:user)
      @fringe = FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff')
      @f_ep1 = FactoryGirl.create(:episode, :series => @fringe, :name => "Fringe - Episode 1")
      @f_ep2 = FactoryGirl.create(:episode, :series => @fringe, :name => "Fringe - Episode 2")
    end

    def do_post(params = {})
      post :create, params
    end

    it 'should be successful' do
      do_post :series_id => @fringe.id
      response.should redirect_to series_index_path
    end

    it 'should create viewings for each episode' do
      lambda {
        do_post :series_id => @fringe.id
      }.should change(Viewing, :count).by(2)
    end
  end
end
