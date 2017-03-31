class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id, index: true
      t.integer :topic_id, index: true
      t.integer :comment_id
      t.string :image

      t.timestamps null: false
    end
  end
end
