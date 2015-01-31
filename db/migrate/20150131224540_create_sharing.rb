class CreateSharing < ActiveRecord::Migration
  def change
    create_table :sharings do |t|
      t.timestamps
      t.integer :file_entity_id
      t.integer :user_id
    end
    add_index :sharings, :file_entity_id
    add_index :sharings, :user_id
  end
end
