require "rails_helper"

describe QuotaController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.create email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123'
    sign_in @user
    @directory = Directory.create user_id: @user.id, name: 'testdirectory'
    @file = FileEntity.create directory_id: @directory.id, attachment: File.new(Rails.root + 'spec/fixtures/images/test.png')
  end

  it 'should properly set quota' do
    expect(@user.reload.quota).to eq(@file.attachment_file_size)
    @file.free_quota
    @file.destroy
    expect(@user.reload.quota).to eq(0)
  end

  it 'should properly get quota' do
    get :quota
    expect(response.status).to eq(200)
    expect(response.body).to eq('Your files take 2764 out of 20000 availible for you')
  end
end