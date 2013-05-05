require 'spec_helper'

describe ViewingsController do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    log_in(user)
  end

  describe "POST 'create'" do
    let(:fringe) { FactoryGirl.create(:series, name: 'Fringe', overview: 'Supernatural stuff') }
    let!(:f_ep1) { FactoryGirl.create(:episode, series: fringe, name: "Fringe - Episode 1") }
    let!(:f_ep2) { FactoryGirl.create(:episode, series: fringe, name: "Fringe - Episode 2") }

    def do_post(params = {})
      post :create,  { series_id: fringe.id }.merge(params)
    end

    it 'should be successful' do
      do_post
      expect(response).to redirect_to(series_index_path)
    end

    it 'should create viewings for each episode' do
      expect { do_post }.to change(user.viewings, :count).by(2)
    end

    it 'should redirect to the home page if user not authorized' do
      log_out
      do_post

      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST 'update'" do
    let!(:v1)  { FactoryGirl.create(:viewing, user: user) }

    def do_post(params = {})
      post :update, { id: v1.id }.merge(params)
    end

    it 'should be successful' do
      do_post

      expect(response).to redirect_to(progressions_path)
    end

    it 'should mark the viewing as viewed' do
      expect(user.last_viewing(v1.series_id)).to be_nil

      do_post

      expect(user.last_viewing(v1.series_id)).to_not be_nil
    end

    it 'should redirect to the home page if user not authorized' do
      v2 = FactoryGirl.create(:viewing, user: FactoryGirl.create(:user))

      do_post id: v2.id

      expect(response).to redirect_to(root_path)
    end
  end
end
