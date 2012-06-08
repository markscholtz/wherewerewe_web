require 'spec_helper'

describe UsersController do
  describe 'GET "new"' do
    it 'should be successful' do
      get 'new'
      response.should be_success
    end

    it 'should populate a user for the view' do
      get 'new'
      assigns[:user].should_not be_nil
    end
  end

  describe 'POST "create"' do
    def do_post(params = {})
      post :create, { :user => { :email => 'mark@example.com',
                                 :password => 'crypt1c',
                                 :password_confirmation => 'crypt1c' }}.reverse_merge(params)
    end

    it 'should be successful' do
      do_post
      response.should redirect_to viewings_path
    end

    it 'should populate a user for the view' do
      do_post
      assigns[:user].should_not be_nil
    end
  end
end
