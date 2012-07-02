require 'spec_helper'

describe ViewingsController do
  let (:user) { FactoryGirl.create(:user) }

  before :each do
    log_in(user)
  end

  describe 'GET "index"' do
    it 'should be successful' do
      get 'index'
      response.should be_success
    end

    it 'should populate a user for the view' do
      get 'index'
      assigns[:series].should_not be_nil
    end
  end

  describe "POST 'create'" do
    let (:fringe) { FactoryGirl.create(:series, :name => 'Fringe', :overview => 'Supernatural stuff') }
    let! (:f_ep1)  { FactoryGirl.create(:episode, :series => fringe, :name => "Fringe - Episode 1") }
    let! (:f_ep2)  { FactoryGirl.create(:episode, :series => fringe, :name => "Fringe - Episode 2") }

    def do_post(params = {})
      post :create, params
    end

    it 'should be successful' do
      do_post :series_id => fringe.id
      response.should redirect_to series_index_path
    end

    it 'should create viewings for each episode' do
      lambda {
        do_post :series_id => fringe.id
      }.should change(user.viewings, :count).by(2)
    end
  end

  describe "POST 'update'" do
    let! (:v1)  { FactoryGirl.create(:viewing, :user => user) }

    def do_post(params = {})
      post :update, { :id => v1.id }.merge(params)
    end

    it 'should be successful' do
      do_post
      response.should redirect_to viewings_path
    end

    it 'should mark the viewing as viewed' do
      user.last_viewing(v1.series_id).should be_nil
      do_post
      user.last_viewing(v1.series_id).should_not be_nil
    end
  end
end
