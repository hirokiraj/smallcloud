class Sharing < ActiveRecord::Base
  belongs_to :file_entity
  belongs_to :user

  validates :file_entity_id, :user_id, presence: true
end