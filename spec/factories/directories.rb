# coding: UTF-8

FactoryGirl.define do
  factory :directory, class: 'Directory' do
    name 'example'
    factory :directory_with_file do
      after(:create) do |directory|
        create(:file_entity, directory: directory)
      end
    end
  end
end