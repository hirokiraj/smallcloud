class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :user_id
    end
    add_index :directories, :parent_id
    add_index :directories, :user_id
  end
end
