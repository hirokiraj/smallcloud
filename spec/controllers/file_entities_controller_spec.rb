require "rails_helper"

describe FileEntitiesController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user_with_directory_and_file)
    @directory = user.directories.first
    sign_in user
    @user = User.last
  end

  it "should get index" do
    get :index, {}, { "Accept" => "application/json" }
    expect(response.status).to eq(200)
  end

  it ' user can see entity' do
    get :show, {id: @user.directories.first.file_entities.first}, { "Accept" => "application/json" }
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["attachment_file_name"]).to eq "example_file"
  end

  it 'user can add file' do
    post :create, {file_entity:{name:"directory2"}}, { "Accept" => "application/json", "Content-Type" => "application/json"}
    expect(response.status).to eq(201)
    expect(Directory.last.name).to eq "directory2"
  end

  it 'user can delete file directory' do
    delete :destroy, {id: @directory.id}, { "Accept" => "application/json" }
    expect(response.status).to eq(204)
    expect(Directory.all.count).to eq 0
  end

end