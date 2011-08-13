require 'spec_helper'

describe Viewing do
  describe 'validations' do
    before :each do
      @viewing = Factory(:viewing)
    end

    it 'should have a valid factory' do
      @viewing.should be_valid
    end

    it 'should require a episode_id' do
      @viewing.episode_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:episode_id).should_not be_blank
    end

    it 'should require a user_id' do
      @viewing.user_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:user_id).should_not be_blank
    end
  end

  describe 'associations' do
    before :each do
      @episode = Factory(:episode)
      @user = Factory(:user)
      @viewing = Factory(:viewing, :episode => @episode, :user => @user)
    end

    it "should be destroyed along with it's episode" do
      @episode.viewings.should include(@viewing)
      @episode.destroy
      Viewing.find_by_id(@viewing.id).should be_nil
    end

    it "should be destroyed along with it's user" do
      @user.viewings.should include(@viewing)
      @user.destroy
      User.find_by_id(@user.id).should be_nil
    end
  end
end
