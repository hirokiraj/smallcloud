require "rails_helper"

describe SearchController do

  describe 'Unauthorized user' do

    it "unauthorized user cant search files" do
      get :search, {search_term: 'example_file'}, { "Accept" => "application/json" }
      expect(response.status).to eq(401)
    end
  end

  describe 'User search' do

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user_with_directory_and_file)
      sign_in @user
    end

    it "should return file on search" do
      get :search, {search_term: 'example_file'}, { "Accept" => "application/json", 'Content-Type' => 'application/json'  }
      controller.params[:search_term].should eql 'example_file'
      expect(response.status).to eq(200)
    end

    it "should return info with no file" do
      get :search, {search_term: 'no_file'}, { "Accept" => "application/json" }
      expect(response.status).to eq(204)
    end

    it "should return info about no search term" do
      get :search, {search_term: nil}, { "Accept" => "application/json" }
      expect(response.status).to eq(400)
    end
  end
end