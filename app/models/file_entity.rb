class FileEntity < ActiveRecord::Base
  belongs_to :directory
  belongs_to :user#, through: :directory
  has_many :sharings
  has_attached_file :attachment

  validates_with AttachmentSizeValidator, :attributes => :attachment, :less_than => 5.megabytes
  validates :attachment, :attachment_presence => true
  validates :directory_id, presence: true
  do_not_validate_attachment_file_type :attachment

  after_create :take_quota

  # def as_json(options={})
  #   {
  #     id: self.id,
  #     created_at: self.created_at,
  #     directory_id: self.directory_id,
  #     attachment_file_name: self.attachment_file_name,
  #     attachment_content_type: self.attachment_content_type,
  #     attachment_file_size: self.attachment_file_size
  #   }
  # end

  def attachment_url
    return self.attachment.url
  end

  def free_quota
    self.directory.user.free_quota attachment_file_size
  end

  private

  def take_quota
    self.directory.user.take_quota attachment_file_size
  end
end