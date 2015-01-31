class CreateFileEntity < ActiveRecord::Migration
  def change
    create_table :file_entities do |t|
      t.timestamps
      t.integer :directory_id
    end
    add_index :file_entities, :directory_id
  end
end
