require "rails_helper"

describe DirectoriesController do

  describe 'Unauthorized user' do

    it "unauthorized user cant see index" do
      get :index, {}, { "Accept" => "application/json" }
      expect(response.status).to eq(401)
    end

    it 'unauthorized user cant see directory' do
      @user = FactoryGirl.create(:user_with_directory)
      get :show, {id: @user.directories.first.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(401)
    end

  end

  describe 'User directories' do

    login_user

    it "should get index" do
      get :index, {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end

    it ' user can see directory' do
      get :show, {id: @user.directories.first.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq "example"
    end

    it 'user can add directory' do
      post :create, {directory:{name:"directory2"}}, { "Accept" => "application/json", "Content-Type" => "application/json"}
      expect(response.status).to eq(201)
      expect(Directory.last.name).to eq "directory2"
    end

    it 'user can delete directory' do
      delete :destroy, {id: @user.directories.first.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(204)
      expect(Directory.all.count).to eq 0
    end
  end
end