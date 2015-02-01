require "rails_helper"

describe FileEntity do
  it { should have_attached_file(:attachment) }
  it { should validate_attachment_presence(:attachment) }
  it { should validate_attachment_size(:attachment).less_than(5.megabytes) }
  it "Relations" do
    should belong_to(:directory)
  end
end