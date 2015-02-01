require "rails_helper"

# Use methods from api helper !
describe SessionsController do

  before do
    @user = FactoryGirl.create :user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create /users/sign_in' do

    it 'properly authenticates user' do
      post :create, user: {email: 'email@example.com', password: 'password'}, format: :json
      expect(response.status).to eq(200)
      @user.reload
      expect(assigns(:user)).to eq(@user)
      json = JSON.parse(response.body)
      expect(json['authentication_token']).to be_present
    end

    it 'shows errors when trying to provide incorrect data' do
      post :create, user: {email: 'email@example.com', password: 'wrong_password'}
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE destroy' do
    it 'should properly sign user out' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123'
      sign_in @user
      delete :destroy, format: :json
      expect(response.status).to eq(200)
    end
  end
end