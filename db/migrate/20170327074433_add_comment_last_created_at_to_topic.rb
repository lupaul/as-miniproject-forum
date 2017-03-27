class AddCommentLastCreatedAtToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :last_time, :datetime, index: true
  end
end
