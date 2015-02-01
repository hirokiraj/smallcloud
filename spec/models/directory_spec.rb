require "rails_helper"

RSpec.describe Directory, :type => :model do
  it "Validation" do
    should validate_presence_of(:user_id)
    should validate_length_of(:name).is_at_most(20).is_at_least(3)
  end

  it "Relations" do
    should belong_to(:user)
    should have_many(:file_entities)
  end

  it "Should validate if user exists" do
    @user = User.create!(email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123')
    dir1 = Directory.create(user_id: @user.id, name: 'test1')
    dir2 = Directory.create(user_id: @user.id+1, name: 'test2')
    expect(dir1.persisted?).to eq(true)
    expect(dir2.errors.full_messages).to eq(["User does not match any existing user"])
  end

  it "Should validate if parent exists and belongs to user" do
    @owner = User.create!(email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123')
    @other_guy = User.create!(email: 'test2@test.com', password: 'test123123', password_confirmation: 'test123123')

    dir1 = Directory.create(user_id: @owner.id, name: 'test1')
    dir2 = Directory.create(user_id: @other_guy.id, name: 'test2')

    dir3 = Directory.create(user_id: @owner.id, name: 'test1', parent_id: dir1.id)
    dir4 = Directory.create(user_id: @owner.id, name: 'test1', parent_id: dir1.id+30)
    dir5 = Directory.create(user_id: @other_guy.id, name: 'test1', parent_id: dir1.id)
    expect(dir3.persisted?).to eq(true)
    expect(dir4.errors.full_messages).to eq(["Parent does not match any existing directory"])
    expect(dir5.errors.full_messages).to eq(["Parent directory does not belong to You"])
  end

  it 'Should return top level directories' do
    @owner = User.create!(email: 'test@test.com', password: 'test123123', password_confirmation: 'test123123')
    dir1 = Directory.create(user_id: @owner.id, name: 'test1')
    dir2 = Directory.create(user_id: @owner.id, name: 'test2')
    dir3 = Directory.create(user_id: @owner.id, name: 'test1', parent_id: dir1.id)
    dir4 = Directory.create(user_id: @owner.id, name: 'test1', parent_id: dir2.id)

    expect(@owner.directories.size).to eq(4)
    expect(@owner.directories.top_level.size).to eq(2)
  end
end
