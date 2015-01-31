class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :validatable

  has_many :directories
  has_many :file_entities, through: :directories

  before_create :set_quota_to_0

  def quota_above_limit?
    quota > Rails.application.secrets.max_quota
  end

  private

  def set_quota_to_0
    quota = 0
  end
end
