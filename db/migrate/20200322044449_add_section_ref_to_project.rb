class AddSectionRefToProject < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :section, index: true
  end
end
