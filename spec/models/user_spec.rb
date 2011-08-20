require 'spec_helper'

describe User do
  before :each do
    @user = Factory(:user)
  end

  describe 'validations' do
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

  describe 'associations' do
    before :each do
      @series1 = Factory(:series)
      @series2 = Factory(:series)
      @episode1 = Factory(:episode)
      @episode2 = Factory(:episode)
      @viewing1 = Factory(:viewing, :user => @user, :episode => @episode1, :series => @series1)
      @viewing2 = Factory(:viewing, :user => @user, :episode => @episode1, :series => @series2)
      @viewing3 = Factory(:viewing, :user => @user, :episode => @episode2, :series => @series2)
    end

    it 'should return distinct episodes being watched by the user' do
      @user.episodes.size.should == 2
      @user.episodes.should ==[@episode1, @episode2]
    end

    it 'should return distinct series being watched by the user' do
      @user.series.size.should == 2
      @user.series.should ==[@series1, @series2]
    end
  end
end
