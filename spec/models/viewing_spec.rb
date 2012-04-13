require 'spec_helper'

describe Viewing do

  describe 'validations' do

    before :each do
      @viewing = FactoryGirl.create(:viewing)
    end

    it 'should have a valid factory' do
      @viewing.should be_valid
    end

    it 'should require an episode_id' do
      @viewing.episode_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:episode_id).should_not be_blank
    end

    it 'should require a series_id' do
      @viewing.series_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:series_id).should_not be_blank
    end

    it 'should require a season_id' do
      @viewing.season_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:season_id).should_not be_blank
    end

    it 'should require a user_id' do
      @viewing.user_id = nil
      @viewing.should_not be_valid
      @viewing.errors_on(:user_id).should_not be_blank
    end

  end

  describe 'associations' do

    before :each do
      @episode = FactoryGirl.create(:episode)
      @user = FactoryGirl.create(:user)
      @viewing = FactoryGirl.create(:viewing, :episode => @episode, :user => @user)
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
      @mark = FactoryGirl.create(:user)
      @jo   = FactoryGirl.create(:user)

      @boston_legal  = FactoryGirl.create(:series, :name => "Boston Legal")
      @house         = FactoryGirl.create(:series, :name => "House")
      @grays_anatomy = FactoryGirl.create(:series, :name => "Gray's Anatomy")
      @dawsons_creek = FactoryGirl.create(:series, :name => "Dawson's Creek")

      @bl_s1   = FactoryGirl.create(:season, :number => 1, :series => @boston_legal)
      @bl_s2   = FactoryGirl.create(:season, :number => 2, :series => @boston_legal)
      @h_s1    = FactoryGirl.create(:season, :number => 1, :series => @house)
      @ga_s1   = FactoryGirl.create(:season, :number => 1, :series => @grays_anatomy)
      @dc_s1   = FactoryGirl.create(:season, :number => 1, :series => @dawsons_creek)

      @bl_ep1  = FactoryGirl.create(:episode, :number => 1, :series => @boston_legal, :season => @bl_s1)
      @bl_ep2  = FactoryGirl.create(:episode, :number => 2, :series => @boston_legal, :season => @bl_s1)
      @bl_ep3  = FactoryGirl.create(:episode, :number => 3, :series => @boston_legal, :season => @bl_s1)
      @bl_ep4  = FactoryGirl.create(:episode, :number => 1, :series => @boston_legal, :season => @bl_s2)

      @h_ep1   = FactoryGirl.create(:episode, :number => 1, :series => @house, :season => @h_s1)
      @h_ep2   = FactoryGirl.create(:episode, :number => 2, :series => @house, :season => @h_s1)
      @h_ep3   = FactoryGirl.create(:episode, :number => 3, :series => @house, :season => @h_s1)
      @h_ep4   = FactoryGirl.create(:episode, :number => 4, :series => @house, :season => @h_s1)

      @ga_ep1  = FactoryGirl.create(:episode, :number => 1, :series => @grays_anatomy, :season => @ga_s1)
      @ga_ep2  = FactoryGirl.create(:episode, :number => 2, :series => @grays_anatomy, :season => @ga_s1)

      @mark_v1 = FactoryGirl.create(:viewing, :user => @mark, :episode => @bl_ep1, :season => @bl_s1, :series => @boston_legal,  :viewed_at => 3.days.ago)
      @mark_v2 = FactoryGirl.create(:viewing, :user => @mark, :episode => @bl_ep2, :season => @bl_s1, :series => @boston_legal)
      @mark_v3 = FactoryGirl.create(:viewing, :user => @mark, :episode => @bl_ep3, :season => @bl_s1, :series => @boston_legal,  :viewed_at => 2.days.ago)
      @mark_v8 = FactoryGirl.create(:viewing, :user => @mark, :episode => @bl_ep4, :season => @bl_s2, :series => @boston_legal)

      @mark_v4 = FactoryGirl.create(:viewing, :user => @mark, :episode => @h_ep1,  :season => @h_s1,  :series => @house,         :viewed_at => 6.days.ago)
      @mark_v5 = FactoryGirl.create(:viewing, :user => @mark, :episode => @h_ep2,  :season => @h_s1,  :series => @house,         :viewed_at => 8.days.ago)
      @mark_v6 = FactoryGirl.create(:viewing, :user => @mark, :episode => @h_ep4,  :season => @h_s1,  :series => @house)
      @mark_v7 = FactoryGirl.create(:viewing, :user => @mark, :episode => @h_ep3,  :season => @h_s1,  :series => @house)

      @jo_v1   = FactoryGirl.create(:viewing, :user => @jo,   :episode => @bl_ep3, :season => @bl_s1, :series => @boston_legal,  :viewed_at => 5.days.ago)
      @jo_v2   = FactoryGirl.create(:viewing, :user => @jo,   :episode => @bl_ep2, :season => @bl_s1, :series => @boston_legal)
      @jo_v3   = FactoryGirl.create(:viewing, :user => @jo,   :episode => @bl_ep1, :season => @bl_s1, :series => @boston_legal)

      @jo_v4   = FactoryGirl.create(:viewing, :user => @jo,   :episode => @ga_ep1, :season => @ga_s1, :series => @grays_anatomy, :viewed_at => 2.days.ago)
      @jo_v5   = FactoryGirl.create(:viewing, :user => @jo,   :episode => @ga_ep2, :season => @ga_s1, :series => @grays_anatomy, :viewed_at => 1.days.ago)
    end

    describe 'to retrieve the last viewed viewing' do

      context 'for a given user' do

        it 'should return the most recently viewed viewing of any series' do
          Viewing.last(user_id: @jo.id).first.should == @jo_v5
        end

      end

      context 'for a given episode' do

        it 'should return the most recently viewed viewing of that episode across all users' do
          Viewing.last(episode_id: @bl_ep3.id).first.should == @mark_v3
        end

      end

      context 'for a given series' do

        it 'should return the most recently viewed viewing of any episode in that series across all users' do
          Viewing.last(series_id: @boston_legal.id).first.should == @mark_v3
        end

        it 'should return nil if no episode has been viewed' do
          Viewing.last(series_id: @dawsons_creek.id).first.should be_nil
        end

      end

      context 'for a given user and series' do

        it 'should return the most recently viewed viewing of any episode for that series for the given user' do
          Viewing.last(user_id: @mark.id, series_id: @house.id).first.should == @mark_v4
        end

      end

    end

    describe 'to retrieve the next viewing to watch' do

      context 'when some episodes have been watched in sequence' do

        it 'should return the first unwatched episode for the given user and series' do
          Viewing.next(@mark.id, @house.id).first.should == @mark_v7
        end

      end

      context 'when some episodes have been watched out of sequence' do

        it 'should return the first unwatched episode for the given user and series' do
          # binding.pry
          Viewing.next(@mark.id, @boston_legal.id).first.should == @mark_v2
        end

      end

      context 'when no viewings exist for the given series' do

        it 'should return nil for the given user and series' do
          Viewing.next(@jo.id, @house.id).first.should be_nil
        end

      end

      context 'when all episodes have been watched' do

        it 'should return nil for for the given user and series' do
          Viewing.next(@jo.id, @grays_anatomy.id).first.should be_nil
        end

      end

    end

  end

end
