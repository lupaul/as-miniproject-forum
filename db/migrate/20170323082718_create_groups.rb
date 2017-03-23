class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.date :date
      t.string :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
