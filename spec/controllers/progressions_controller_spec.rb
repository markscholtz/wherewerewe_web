require 'spec_helper'

describe ProgressionsController do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    log_in(user)
  end

  describe 'GET "index"' do
    it 'should be successful' do
      get :index
      response.should be_success
    end

    it 'should find all progressions for the current user' do
      FactoryGirl.create(:series)

      get :index
      assigns[:progressions].should_not be_nil
      assigns[:progressions].each { |p| p.user.should == user }
    end

    it 'should redirect to the home page if user not authorized' do
      log_out
      get :index

      expect(response).to redirect_to(root_path)
    end
  end
end
