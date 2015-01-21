class Directory < ActiveRecord::Base
  belongs_to :user
  acts_as_tree order: 'name'

  validates :user_id, :name, presence: true
  validates :name, length: { in: 3..20 }
  validate :parent_must_exist_and_belong_to_user
  validate :user_must_exist

  scope :top_level, ->{ where(parent_id: nil) }

  private

  def parent_must_exist_and_belong_to_user
    if self.parent_id && !Directory.find_by_id(self.parent_id)
      errors.add(:parent_id, 'does not match any existing directory')
    elsif self.parent_id && !(Directory.find_by_id(self.parent_id).try(:user_id) == self.user_id)
      errors.add(:parent_id, 'directory does not belong to You')
    end
  end

  def user_must_exist
    errors.add(:user_id, 'does not match any existing user') unless User.find_by_id(self.user_id)
  end
end