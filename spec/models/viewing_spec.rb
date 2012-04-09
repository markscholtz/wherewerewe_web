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

    it 'should require a series_id' do
      @viewing.series_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:series_id).should_not be_blank
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

  describe 'scopes' do
    before :each do
      @mark = Factory(:user)
      @jo   = Factory(:user)
      @boston_legal  = Factory(:series)
      @house         = Factory(:series)
      @grays_anatomy = Factory(:series)
      @dawsons_creek = Factory(:series)
      @bl_s1   = Factory(:season, :number => 1, :series => @boston_legal)
      @bl_s2   = Factory(:season, :number => 2, :series => @boston_legal)
      @bl_ep1  = Factory(:episode, :number => 1, :series => @boston_legal, :season => @bl_s1)
      @bl_ep2  = Factory(:episode, :number => 2, :series => @boston_legal, :season => @bl_s1)
      @bl_ep3  = Factory(:episode, :number => 3, :series => @boston_legal, :season => @bl_s1)
      @bl_ep4  = Factory(:episode, :number => 1, :series => @boston_legal, :season => @bl_s2)
      @h_ep1   = Factory(:episode, :number => 1, :series => @house)
      @h_ep2   = Factory(:episode, :number => 2, :series => @house)
      @h_ep3   = Factory(:episode, :number => 3, :series => @house)
      @h_ep4   = Factory(:episode, :number => 4, :series => @house)
      @ga_ep1  = Factory(:episode, :number => 1, :series => @grays_anatomy)
      @ga_ep2  = Factory(:episode, :number => 2, :series => @grays_anatomy)
      @mark_v1 = Factory(:viewing, :user => @mark, :episode => @bl_ep1, :season => @bl_s1,                :series => @boston_legal,  :viewed_at => 3.days.ago)
      @mark_v2 = Factory(:viewing, :user => @mark, :episode => @bl_ep2, :season => @bl_s1,                :series => @boston_legal)
      @mark_v3 = Factory(:viewing, :user => @mark, :episode => @bl_ep3, :season => @bl_s1,                :series => @boston_legal,  :viewed_at => 2.days.ago)
      @mark_v8 = Factory(:viewing, :user => @mark, :episode => @bl_ep4, :season => @bl_s2,                :series => @boston_legal)
      @mark_v4 = Factory(:viewing, :user => @mark, :episode => @h_ep1,  :season => @house.season,         :series => @house,         :viewed_at => 6.days.ago)
      @mark_v5 = Factory(:viewing, :user => @mark, :episode => @h_ep2,  :season => @house.season,         :series => @house,         :viewed_at => 8.days.ago)
      @mark_v6 = Factory(:viewing, :user => @mark, :episode => @h_ep4,  :season => @house.season,         :series => @house)
      @mark_v7 = Factory(:viewing, :user => @mark, :episode => @h_ep3,  :season => @house.season,         :series => @house)
      @jo_v1   = Factory(:viewing, :user => @jo,   :episode => @bl_ep3, :season => @boston_legal.season,  :series => @boston_legal,  :viewed_at => 5.days.ago)
      @jo_v2   = Factory(:viewing, :user => @jo,   :episode => @bl_ep2, :season => @boston_legal.season,  :series => @boston_legal)
      @jo_v3   = Factory(:viewing, :user => @jo,   :episode => @bl_ep1, :season => @boston_legal.season,  :series => @boston_legal)
      @jo_v4   = Factory(:viewing, :user => @jo,   :episode => @ga_ep1, :season => @grays_anatomy.season, :series => @grays_anatomy, :viewed_at => 2.days.ago)
      @jo_v5   = Factory(:viewing, :user => @jo,   :episode => @ga_ep2, :season => @grays_anatomy.season, :series => @grays_anatomy, :viewed_at => 1.days.ago)
    end

    describe 'last' do
      it 'should return the most recently viewed viewing for the given arguments' do
        Viewing.last(user_id: @jo.id).first.should == @jo_v5
        Viewing.last(episode_id: @bl_ep3.id).first.should == @mark_v3
        Viewing.last(series_id: @boston_legal.id).first.should == @mark_v3
        Viewing.last(series_id: @dawsons_creek.id).first.should be_nil
        Viewing.last(user_id: @mark.id, series_id: @house.id).first.should == @mark_v4
      end
    end

    describe 'next' do
      it 'should return the next viewing to watch for the given user and series' do
        Viewing.next(@mark.id, @house.id).first.should == @mark_v7
        Viewing.next(@mark.id, @boston_legal.id).first.should == @mark_v2
        Viewing.next(@jo.id, @house.id).first.should be_nil
        Viewing.next(@jo.id, @grays_anatomy.id).first.should be_nil
      end
    end
  end
end
