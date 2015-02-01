# coding: UTF-8

FactoryGirl.define do
  factory :file_entity, class: 'FileEntity' do
    attachment_file_name 'example_file'
    attachment_content_type ''
    attachment_file_size ''
    #fixture_file_upload('spec/samples/laptop1.jpg', 'image/jpg')
  end
end