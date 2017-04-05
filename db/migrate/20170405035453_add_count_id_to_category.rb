class AddCountIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :count, :integer, default: 0

  end
end
