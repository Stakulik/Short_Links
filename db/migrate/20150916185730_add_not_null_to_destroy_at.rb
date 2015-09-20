class AddNotNullToDestroyAt < ActiveRecord::Migration
  def change
    change_column :links, :destroy_at, :datetime, :null => false
  end
end
