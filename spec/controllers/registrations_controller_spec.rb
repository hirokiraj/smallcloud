require "rails_helper"

# Use methods from api helper !
describe RegistrationsController do

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create /users' do

    it 'register new user' do
      post :create, { user: {login: 'email@example.com', password: 'password'}}, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json' }
      expect(response.status).to eq(201)
      json = JSON.parse(response.body)
      expect(json['state']['code']).to eq(0)
    end
  end
end