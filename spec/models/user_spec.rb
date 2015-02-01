require "rails_helper"

describe User do
  it "Relations" do
    should have_many(:directories)
    should have_many(:file_entities).through(:directories)
    should have_many(:sharings)
  end

  it 'should return quota' do
    @user = User.create(email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123')
    expect(@user.quota_above_limit?).to eq(false)
  end

  it 'should take quota' do
    @user = User.create(email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123')
    @user.take_quota(1000)
    expect(@user.quota).to eq(1000)
  end

  it 'should free quota' do
    @user = User.create(email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123')
    @user.quota = 1000
    @user.save
    @user.free_quota(500)
    expect(@user.quota).to eq(500)
  end
end