# coding: UTF-8

FactoryGirl.define do
  factory :file_entity, class: 'FileEntity' do
    attachment_file_name 'example_file'
    attachment_content_type ''
    attachment_file_size ''
  end
end