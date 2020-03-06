class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.integer :max_group_size
      t.integer :min_group_size
      t.string :topics
      t.boolean :hardware
      t.boolean :industry_sponsored
      t.string :client

      t.timestamps
    end
  end
end
