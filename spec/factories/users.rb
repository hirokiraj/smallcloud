# coding: UTF-8

FactoryGirl.define do
  factory :user, class: 'User' do
    email 'email@example.com'
    password 'password'
    factory :user_with_directory do
      after(:create) do |user|
        create(:directory, user: user)
      end
    end
    factory :user_with_directory_and_file do
      after(:create) do |user|
        create(:directory_with_file, user: user)
      end
    end
  end
end