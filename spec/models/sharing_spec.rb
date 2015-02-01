require "rails_helper"

describe Sharing do
  it 'Relations' do
    should belong_to(:file_entity)
    should belong_to(:user)
  end

  it 'Validations' do
    should validate_presence_of(:file_entity_id)
    should validate_presence_of(:user_id)
  end
end