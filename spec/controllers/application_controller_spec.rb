require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      @current_user = current_user
      render :nothing => true
    end
  end

  describe '#current_user' do
    it 'returns the current user' do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      get :index
      assigns[:current_user].should == user
    end
  end
end
