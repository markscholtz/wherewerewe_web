require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.create(:user)
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
      another_user = FactoryGirl.build(:user, :email => @user.email)
      another_user.should_not be_valid
      another_user.errors_on(:email).should_not be_blank
    end
  end

  describe 'associations' do
    before :each do
      @series1 = FactoryGirl.create(:series)
      @series2 = FactoryGirl.create(:series)
      @episode1 = FactoryGirl.create(:episode)
      @episode2 = FactoryGirl.create(:episode)
      @viewing1 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode1, :series => @series1)
      @viewing2 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode1, :series => @series2)
      @viewing3 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode2, :series => @series2)
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

  describe 'viewing access methods' do
    before :each do
      @series1 = FactoryGirl.create(:series)
      @episode1 = FactoryGirl.create(:episode)
      @episode2 = FactoryGirl.create(:episode)
      @viewing1 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode1, :series => @series1, :viewed_at => 1.day.ago)
      @viewing2 = FactoryGirl.create(:viewing, :user => @user, :episode => @episode2, :series => @series1)
    end

    it 'should return the last viewing for a given series' do
      @user.last_viewing(@series1.id).should == @viewing1
    end

    it 'should return the next viewing for a given series' do
      @user.next_viewing(@series1.id).should == @viewing2
    end
  end
end
