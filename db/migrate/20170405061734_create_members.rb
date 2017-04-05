class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.boolean :admin
      t.integer :weight
      t.timestamps null: false
    end
  end
end
