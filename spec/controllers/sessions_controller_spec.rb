require "rails_helper"

# Use methods from api helper !
describe SessionsController do

  before do
    @user = FactoryGirl.create :user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create /users/sign_in' do

    it 'properly authenticates user' do
      post :create, { user: {login: 'email@example.com', password: 'password'}}, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json' }
      expect(response.status).to eq(200)
      assigns(:user).should be(@user)
      #json = JSON.parse(response.body)
      # expect(resp['success']).to  eq(true)
      # expect(resp['info']).to  eq('Logged in')
      # expect(resp['data']['email']).to  eq('email@example.com')
    end

    it 'shows errors when trying to provide incorrect data' do
      post :create, { user: {login: 'email@exaaaample.com', password: 'password'}}, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json' }
      expect(response.status).to eq(401)
    end

  end

  # describe 'DELETE destroy' do

  #   it 'properly resets user auth token' do
  #     user_old_token = @user.authentication_token
  #     add_headers_to_request(@user.email, @user.authentication_token)
  #     resp = logout_user(@user.email, @user.authentication_token)

  #     expect(response.status).to eq(200)
  #     expect(resp['success']).to  eq(true)
  #     expect(resp['info']).to  eq("Logged out")

  #     user_new_token = User.last.authentication_token
  #     expect(user_new_token).not_to eq(user_old_token)
  #   end

  #   it "should not reset user token when passing improper headers " do
  #     user_old_token = @user.authentication_token
  #     add_headers_to_request("some@email.com", 'some_token')
  #     #resp = logout_user(@user.email, @user.authentication_token)
  #     delete :destroy, {}, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json'}
  #     JSON.parse(response.body)

  #     expect(response.status).to eq(401)
  #     expect(resp['success']).to  eq(false)
  #   end
  # end

end