require "rails_helper"
require 'rack/test'

describe FileEntitiesController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.create email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123'
    sign_in @user
    @directory = Directory.create user_id: @user.id, name: 'testdirectory'
    @file = FileEntity.create directory_id: @directory.id, attachment: File.new(Rails.root + 'spec/fixtures/images/test.png')
  end

  it "should get index" do
    get :index, {}, { "Accept" => "application/json" }
    expect(response.status).to eq(200)
  end

  it ' user can see entity' do
    get :show, id: @file.id
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["attachment_file_name"]).to eq "test.png"
  end

  it 'user can add file' do
    post :create, {file_entity:{directory_id: @directory.id, attachment: Rack::Test::UploadedFile.new(Rails.root + 'spec/fixtures/images/test.png', 'image/png')}}, { "Accept" => "application/json", "Content-Type" => "application/json"}
    expect(response.status).to eq(201)
    expect(FileEntity.last.attachment_file_name).to eq "test.png"
  end

  it 'user can delete file ' do
    delete :destroy, {id: @file.id}, { "Accept" => "application/json" }
    expect(response.status).to eq(204)
    expect(FileEntity.all.count).to eq 0
  end

end