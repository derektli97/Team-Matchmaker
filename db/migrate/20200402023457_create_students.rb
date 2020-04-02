class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.string :ethnicity
      t.string :topics
      t.boolean :hardware
      t.string :electives
      t.string :preferences
      t.references :section, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
