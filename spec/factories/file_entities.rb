# coding: UTF-8

FactoryGirl.define do
  factory :file_entity, class: 'FileEntity' do
    attachment_file_name 'example_file'
    attachment_content_type 'jpg'
    attachment_file_size '5000'
  end
end