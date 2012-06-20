require 'spec_helper'

describe SessionsController do
  describe 'GET "new"' do
    it 'should be successful' do
      get 'new'
      response.should be_success
    end
  end

  describe 'POST "create"' do
    def do_post(params = {})
      post :create, { :email => 'mark@example.com',
                      :password => 'crypt1c'}.reverse_merge(params)
    end

    let!(:user) { FactoryGirl.create(:user,
                                     :email => 'mark@example.com',
                                     :password => 'crypt1c',
                                     :password_confirmation => 'crypt1c') }

    it 'should be successful' do
      do_post
      response.should redirect_to viewings_path
    end

    it 'should set the user_id for the session' do
      do_post
      session[:user_id].should == user.id
    end
  end
end
