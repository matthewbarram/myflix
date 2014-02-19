require 'spec_helper'
require 'pry'

describe VideosController do
  describe 'GET #show' do

    context 'with valid user' do
      before(:each) do
        @simpsons = Video.create(title: 'The Simpsons!', description: 'A family that loves living together.')
        @futurama = Video.create(title: 'Futurama!', description: 'This is a crazy place where people live in the future.')
        @future = Video.create(title: "Future", description: "This is the future.")
        session[:user_id] = Fabricate(:user).id
        get :show, id: @futurama.id
      end

      it 'sets the @video correctly' do
        expect(assigns(:video)).to eq @futurama
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end

      #   it 'sets the @reviews instance variable' do
      #     expect(assigns(:reviews)).to be_instance_of(:reviews)
      #   end
      #   it 'finds all the reviews related to the correct video'
      # end

      context 'without valid user' do
        it 'redirects unauthenticated user to sign in page' do
          futurama = Fabricate(:video)
          get :show, id: futurama.id
          session[:user_id] = nil
          expect(response).to redirect_to login_path
        end
      end
    end

    describe 'POST #search' do
      context 'authenticated user' do
        before(:each) do
          @simpsons = Fabricate(:video, title: "Simpsons")
          @futurama = Fabricate(:video, title: "Futurama")
          @future = Fabricate(:video, title: "Future")
          session[:user_id] = Fabricate(:user).id
          request.env["HTTP_REFERER"] = home_path
        end

        it 'sets the @videos object correctly' do
          post :search, q: 'futur'
          expect(assigns(:videos)).to match_array([@future, @futurama])
        end

        it 'if no results return empty array' do
          post :search, q: 'ttyl4499'
          expect(assigns(:videos)).to match_array([])
        end

        it 'redirects :back if no results are returned.' do
          post :search, q: 'ttyl4499'
          expect(response).to redirect_to(home_path)
        end

        it 'renders the :index template if results are found' do
          post :search, q: 'futur'
          expect(response).to render_template(:search)
        end
      end

      context 'unauthenticated' do
        it 'redirects user to login_path if unauthenticated' do
          simpsons = Fabricate(:video, title: "Simpsons")
          futurama = Fabricate(:video, title: "Futurama")
          future = Fabricate(:video, title: "Future")
          post :search, q: 'futur'
          binding.pry
          expect(response).to redirect_to login_path
        end
      end
    end
  end
end
