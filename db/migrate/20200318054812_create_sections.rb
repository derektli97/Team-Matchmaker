class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :course
      t.string :section

      t.timestamps
    end
  end
end
