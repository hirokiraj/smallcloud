class AddQuotaToUser < ActiveRecord::Migration
  def change
    add_column :users, :quota, :integer
  end
end
