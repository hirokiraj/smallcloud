require "rails_helper"

describe SearchController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.create email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123'
    sign_in @user
    @directory = Directory.create user_id: @user.id, name: 'testdirectory'
    @file = FileEntity.create directory_id: @directory.id, attachment: File.new(Rails.root + 'spec/fixtures/images/test.png')
  end

  it "should return file on search" do
    get :search, search_term: 'test'
    expect(response.status).to eq(200)
  end

  it "should return info with no file" do
    get :search, search_term: 'no_file'
    expect(response.status).to eq(204)
  end

  it "should return info about no search term" do
    get :search, search_term: ''
    expect(response.status).to eq(400)
  end

end