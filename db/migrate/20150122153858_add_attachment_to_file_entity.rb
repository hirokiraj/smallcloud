class AddAttachmentToFileEntity < ActiveRecord::Migration
  def change
    add_attachment :file_entities, :attachment
  end
end
