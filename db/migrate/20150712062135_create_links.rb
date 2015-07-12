class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :original_link, null: false, limit: 400
      t.string :alias_link, null: false

      t.timestamps
    end
  end
end
