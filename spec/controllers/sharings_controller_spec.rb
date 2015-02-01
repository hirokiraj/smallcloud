require "rails_helper"

describe SharingsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user_sharing = User.create email: 'test1@test.com', password: 'test123123', password_confirmation: 'test123123'
    @user_shared_with = User.create email: 'test2@test.com', password: 'test123123', password_confirmation: 'test123123'
    # sign_in @user_sharing
    @directory = Directory.create user_id: @user_sharing.id, name: 'testdirectory'
    @file = FileEntity.create directory_id: @directory.id, attachment: File.new(Rails.root + 'spec/fixtures/images/test.png')
  end

  it 'should index sharings' do
    sign_in @user_sharing
    @sharing = Sharing.create(file_entity_id: @file.id, user_id: @user_shared_with.id)
    sign_in @user_shared_with
    get :index
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json[0]['file_entity_id']).to eq(@file.id)
  end

  it 'should show sharing' do
    sign_in @user_sharing
    @sharing = Sharing.create(file_entity_id: @file.id, user_id: @user_shared_with.id)
    sign_in @user_shared_with
    get :show, id: @sharing.id
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json['file_entity']['attachment_url']).to be_present
  end

  it 'should create sharing' do
    sign_in @user_sharing
    post :create, sharing: {file_entity_id: @file.id, user_id: @user_shared_with}
    expect(response.status).to eq(201)
    json = JSON.parse(response.body)
    expect(json['file_entity_id']).to eq(@file.id)
    expect(json['user_id']).to eq(@user_shared_with.id)
  end

  it 'should destroy sharing as sharer' do
    sign_in @user_sharing
    @sharing = Sharing.create(file_entity_id: @file.id, user_id: @user_shared_with.id)
    delete :destroy, id: @sharing.id
    expect(response.status).to eq(204)
  end

  it 'should destroy sharing as shareer' do
    sign_in @user_sharing
    @sharing = Sharing.create(file_entity_id: @file.id, user_id: @user_shared_with.id)
    sign_in @user_shared_with
    delete :destroy, id: @sharing.id
    expect(response.status).to eq(204)
  end

  it 'should show shared' do
    sign_in @user_sharing
    @sharing = Sharing.create(file_entity_id: @file.id, user_id: @user_shared_with.id)
    get :shared
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json[0]['attachment_file_name']).to eq('test.png')
  end

  it "unauthorized user cant see index" do
    get :index, {}, { "Accept" => "application/json" }
    expect(response.status).to eq(401)
  end
end