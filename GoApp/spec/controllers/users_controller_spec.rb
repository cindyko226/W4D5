require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do 
    it 'render the new user template' do 
      get :new 
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do 
    context 'with valid params' do 
      
      before(:each) do 
        user = User.new(username:'Cindy', password: 'password')
        post :create, params: {user: {username: user.username, password: user.password } }
      end
      it 'log in the user' do 
        expect(session[:session_token]).to eq(User.last.session_token)
      end 

      it 'redirect user' do 
        expect(response).to redirect_to new_user_url
      end
    end

    context 'with invalid params' do 
      it 'renders page with errors' do 
        user = User.create(username: 'Cindy', password: '')
        post :create, params: {user: {username: user.username, password: user.password } }
        expect(flash[:errors]).to be_present
      end
    end
  end

end
