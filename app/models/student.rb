class Student < ApplicationRecord
  belongs_to :section
  belongs_to :project

  @all_project_tags = ['AI', 'ML', 'Networking', 'Operating Systems', 'Cloud Computing', 'Cyber Security', 'Data Science',
                         'Web Development', 'Graphics', 'Robotics', 'Algorithm Theory']

  @genders = ['M', 'F']

  @ethnicities = ['American Indian or Alaska Native', 'Asian', 'Black or African American', 'Hispanic or Latino',
                    'Native Hawaiian or Other Pacific Islander', 'White']

  @electives = ['CSCE 411', 'CSCE 433', 'CSCE 440', 'CSCE 442', 'CSCE 410', 'CSCE 412', 'CSCE 416', 'CSCE 456', 'CSCE 461',
                  'CSCE 462', 'CSCE 463', 'CSCE 464', 'CSCE 465', 'CSCE 469', 'CSCE 429', 'CSCE 430', 'CSCE 431', 'CSCE 434',
                  'CSCE 435', 'CSCE 438', 'CSCE 451', 'CSCE 310', 'CSCE 320', 'CSCE 420', 'CSCE 421', 'CSCE 436', 'CSCE 441',
                  'CSCE 443', 'CSCE 444', 'CSCE 445', 'CSCE 446', 'CSCE 447', 'CSCE 452', 'CSCE 470']

  @yes_no = ['Yes', 'No']

  def self.all_project_tags
      return @all_project_tags
  end

  def self.genders
    return @genders
  end

  def self.ethnicities
    return @ethnicities
  end

  def self.electives
    return @electives
  end

  def self.yes_no
    return @yes_no
  end
end
