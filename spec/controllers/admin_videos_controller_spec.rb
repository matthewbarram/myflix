require 'spec_helper'
require 'pry'

describe Admin::VideosController do
  describe 'GET #new' do
    context 'user is admin' do
      before do
        session[:user_id] = Fabricate(:user, admin: true).id
      end
      it 'sets up video object' do
        get :new
        expect(assigns(:video)).to be_a_new(Video)
      end
      it 'renders the add video page' do
        get :new
        expect(response).to render_template "new"
      end
    end
    context 'user is not admin' do
      it 'checks the user is an admin' do
        Fabricate(:user)
        session[:user_id] = User.last
        get :new
        expect(response).to redirect_to root_path
      end
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :new }
    end
  end

  describe 'POST #create' do
    before do
      session[:user_id] = Fabricate(:user, admin: true).id
    end
    context 'details are valid' do
      it 'creates the video' do
        video_params = Fabricate.attributes_for(:video)
        post :create, video: video_params
        expect(Video.count).to eq(1)
      end
      it 'redirect_to the user to the add video page'
      it 'shows a confirmation msg'
    end
    context 'details are invalid' do
      it 'does not create a video'
      it 'sets the @video instance variable'
      it 'redirects the user to the create page'
      it 'shows a danger msg'
    end
  end
end
