require 'spec_helper'

describe Series do

  describe 'validations' do
    it 'should have a valid factory' do
      FactoryGirl.build(:series).should be_valid
    end

    it 'should have a unique tvdb_id' do
      series = FactoryGirl.create(:series)
      another_series = FactoryGirl.build(:series, :tvdb_id => series.tvdb_id)
      another_series.should_not be_valid
      another_series.errors_on(:tvdb_id).should_not be_blank
    end
  end

  describe 'scopes' do
    describe 'viewed_by_user' do
      let! (:user1)    { FactoryGirl.create(:user) }
      let! (:user2)    { FactoryGirl.create(:user) }
      let! (:series1)  { FactoryGirl.create(:series) }
      let! (:episode1) { FactoryGirl.create(:episode, :series => series1) }
      let! (:viewing1) { FactoryGirl.create(:viewing, :user => user1, :episode => episode1, :series => series1, :viewed_at => 3.days.ago) }
      let! (:viewing2) { FactoryGirl.create(:viewing, :user => user1, :episode => episode1, :series => series1) }
      let! (:viewing3) { FactoryGirl.create(:viewing, :user => user2, :episode => episode1, :series => series1) }

      it 'should return true if the series has any episodes that have been viewed by the user' do
        Series.viewed_by_user(user1.id).should == [series1]
        Series.viewed_by_user(user2.id).should be_empty
      end
    end
  end

  describe 'viewed?' do
    let! (:user)    { FactoryGirl.create(:user) }
    let! (:series)  { FactoryGirl.create(:series) }
    let! (:episode) { FactoryGirl.create(:episode, :series => series) }
    let! (:viewing) { FactoryGirl.create(:viewing, :user => user, :episode => episode, :series => series, :viewed_at => 3.days.ago) }

    it 'should return true if the user has viewed any episodes' do
      series.viewed?(user.id).should be_true
    end

    it 'should return false if the user has not viewed any episodes' do
      viewing.viewed_at = nil
      viewing.save
      series.viewed?(user.id).should be_false
    end
  end

end
