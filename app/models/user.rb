class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :validatable

  has_many :directories
  has_many :file_entities, through: :directories
  has_many :sharings

  after_create :set_quota_to_0

  def quota_above_limit?
    self.reload.quota > Rails.application.secrets.max_quota
  end

  def shared_files
    shared = []
    file_entities.each do |f|
      shared << f unless f.sharings.empty?
    end
    shared
  end

  def take_quota(qsize)
    self.quota += qsize
    self.save
  end

  def free_quota(qsize)
    self.quota -= qsize
    self.save
  end

  private

  def set_quota_to_0
    self.quota = 0
    self.save
  end
end
