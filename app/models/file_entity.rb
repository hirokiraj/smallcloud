class FileEntity < ActiveRecord::Base
  belongs_to :directory
  belongs_to :user#, through: :directory
  has_many :sharings
  has_attached_file :attachment

  validates_with AttachmentSizeValidator, :attributes => :attachment, :less_than => 5.megabytes
  validates :attachment, :attachment_presence => true
  validates :directory_id, presence: true

  #after_create :take_quota
  #before_destroy :free_quota

  def as_json(options={})
    {
      id: self.id,
      created_at: self.created_at,
      directory_id: self.directory_id,
      attachment_file_name: self.attachment_file_name,
      attachment_content_type: self.attachment_content_type,
      attachment_file_size: self.attachment_file_size
    }
  end

  private

  def take_quota
    user.quota += attachment_file_size
    user.save
  end

  def free_quota
    user.quota -= attachment_file_size
    user.save
  end
end