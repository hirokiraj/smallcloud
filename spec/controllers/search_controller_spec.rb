require "rails_helper"

describe SearchController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user_with_directory_and_file)
    sign_in @user
  end

  it "should return file on search" do
    get :search, {search_term: 'example_file'}, { "Accept" => "application/json" }
    expect(response.status).to eq(200)
  end

  it "should return info with no file" do
    get :search, {search_term: 'no_file'}, { "Accept" => "application/json" }
    expect(response.status).to eq(200)
  end

  it "should return info about no search term" do
    get :search, {}, { "Accept" => "application/json" }
    expect(response.status).to eq(200)
  end

end