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
                                 :password_confirmation => 'crypt1c' }}.merge(params)
    end

    it 'should be successful' do
      do_post
      response.should redirect_to progressions_path
    end

    it 'should log in the user after successful sign up' do
      do_post
      current_user.should == User.find_by_email('mark@example.com')
    end

    it 'should redirect to sign up path after failed sign up' do
      do_post({ :user => { :email => '' } })
      response.should redirect_to sign_up_path
    end
  end
end
