require "rails_helper"

describe SharingsController do


  describe 'User sharings' do

    it "unauthorized user cant see index" do
      get :index, {}, { "Accept" => "application/json" }
      expect(response.status).to eq(401)
    end

    it "user see sharings index" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user_with_directory_and_file)
      sign_in @user
      get :index, {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end

    it ' user can see sharing' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user_with_directory_and_file)
      @file = @user.file_entities.first
      @sharing = FactoryGirl.create(:sharing, :user => @user, :file_entity => @file)
      sign_in @user
      get :show, {id: @sharing.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["user_id"]).to eq @user.id
      expect(json["file_entity_id"]).to eq @file.id
    end
  end
end