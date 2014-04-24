require 'spec_helper'
require 'pry'

describe Admin::VideosController do
  describe 'GET #create' do
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
end
