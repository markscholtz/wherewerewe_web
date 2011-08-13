require 'spec_helper'

describe User do
  describe 'validations' do
    before :each do
      @user = Factory(:user)
    end

    it 'should have a valid factory' do
      @user.should be_valid
    end

    it 'should require an email' do
      @user.email = nil
      @user.should_not be_valid
      @user.errors_on(:email).should_not be_blank
    end

    it 'should have a unique email' do
      another_user = Factory.build(:user, :email => @user.email)
      another_user.should_not be_valid
      another_user.errors_on(:email).should_not be_blank
    end
  end
end
