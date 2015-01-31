class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :validatable

  has_many :directories
  has_many :file_entities, through: :directories
end
