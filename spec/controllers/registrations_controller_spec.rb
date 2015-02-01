require "rails_helper"

# Use methods from api helper !
describe RegistrationsController do

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create /users' do

    it 'register new user' do
      post :create, { user: {email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123'}}, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json' }
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json['state']['code']).to eq(0)
      expect(json['data']['authentication_token']).to be_present
      expect(json['data']['quota']).to eq(0)
      expect(User.all.count).to eq 1
    end
  end
end