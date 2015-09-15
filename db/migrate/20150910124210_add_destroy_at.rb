class AddDestroyAt < ActiveRecord::Migration
  def change
    remove_timestamps(:links)
    
    change_table :links do |t|
      t.datetime "destroy_at"
    end
  end
end
