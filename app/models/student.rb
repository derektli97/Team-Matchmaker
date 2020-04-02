class Student < ApplicationRecord
  belongs_to :section
  belongs_to :project

  @all_project_tags = ['AI', 'ML', 'Networking', 'Operating Systems', 'Cloud Computing', 'Cyber Security', 'Data Science',
                         'Web Development', 'Graphics', 'Robotics', 'Algorithm Theory']

  def self.all_project_tags
      return @all_project_tags
  end
end
