class AddViewCountToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :viewcount, :integer, default: 0

  end
end
