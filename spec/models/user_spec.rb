require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe 'validations' do
    it 'should have a valid factory' do
      FactoryGirl.build(:user).should be_valid
    end

    it 'should have a unique email' do
      another_user = FactoryGirl.build(:user, :email => user.email)
      another_user.should_not be_valid
      another_user.errors_on(:email).should_not be_blank
    end
  end

  describe 'associations' do
    let! (:series1)  { FactoryGirl.create(:series) }
    let! (:series2)  { FactoryGirl.create(:series) }
    let! (:episode1) { FactoryGirl.create(:episode) }
    let! (:episode2) { FactoryGirl.create(:episode) }
    let! (:viewing1) { FactoryGirl.create(:viewing, :user => user, :episode => episode1, :series => series1) }
    let! (:viewing2) { FactoryGirl.create(:viewing, :user => user, :episode => episode1, :series => series2) }
    let! (:viewing3) { FactoryGirl.create(:viewing, :user => user, :episode => episode2, :series => series2) }

    it 'should return distinct episodes being watched by the user' do
      user.episodes.size.should == 2
      user.episodes.should ==[episode1, episode2]
    end

    it 'should return distinct series being watched by the user' do
      user.series.size.should == 2
      user.series.should ==[series1, series2]
    end
  end

  describe 'viewing access methods' do
    let! (:series1)  { FactoryGirl.create(:series) }
    let! (:episode1) { FactoryGirl.create(:episode) }
    let! (:episode2) { FactoryGirl.create(:episode) }
    let! (:viewing1) { FactoryGirl.create(:viewing, :user => user, :episode => episode1, :series => series1, :viewed_at => 1.day.ago) }
    let! (:viewing2) { FactoryGirl.create(:viewing, :user => user, :episode => episode2, :series => series1) }

    it 'should return the last viewing for a given series' do
      user.last_viewing(series1.id).should == viewing1
    end

    it 'should return th next viewing for a gien series' do
      user.next_viewing(series1.id).should == viewing2
    end
  end

  describe 'authentication' do
    let!(:user) { FactoryGirl.create(:user,
                                     :email => 'mark@example.com',
                                     :password => 'crypt1c',
                                     :password_confirmation => 'crypt1c') }

    it 'should encrypt password before save' do
      jo = FactoryGirl.build(:user, :email => 'jo@example.com', :password => 'password')
      jo.save
      jo.password_salt.should_not be_nil
      jo.password_hash.should_not be_nil
    end

    it 'should authenticate with correct details' do
      User.authenticate('mark@example.com', 'crypt1c').should == user
    end

    it 'should fail with incorrect details' do
      User.authenticate('mark@example.com', 'wrong password').should be_nil
    end
  end

  describe 'progressions' do
    let! (:viewing1)  { FactoryGirl.create(:viewing, user: user) }
    let! (:viewing2)  { FactoryGirl.create(:viewing, user: user) }

    it 'should display series progress for each series' do
      user.progressions.count.should == 2
    end
  end
end
