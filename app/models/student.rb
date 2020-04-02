class Student < ApplicationRecord
  belongs_to :section
  belongs_to :project
end
