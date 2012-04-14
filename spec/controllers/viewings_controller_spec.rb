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
end
