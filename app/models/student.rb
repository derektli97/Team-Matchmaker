class Student < ApplicationRecord
  #belongs_to :section
  #belongs_to :project

  @all_project_tags = ['Algorithms', 'Artificial Intelligence', 'Cloud Computing', 'Compiler Theory', 'Computer Architecture', 'Computer Graphics',
                        'Cryptography', 'Cybersecurity', 'Data Structures', 'Data Science', 'Database Systems',
                        'Human Computer Interaction', 'Machine Learning', 'Natural Language Processing', 'Networking',
                        'Operating Systems', 'Parallel Computing', 'Programming Languages', 'Robotics', 'Software Engineering']

  @genders = ['M', 'F']

  @ethnicities = ['American Indian or Alaska Native', 'Asian', 'Black or African American', 'Hispanic or Latino',
                    'Native Hawaiian or Other Pacific Islander', 'White']

  @electives = ['CSCE 411', 'CSCE 433', 'CSCE 440', 'CSCE 442', 'CSCE 410', 'CSCE 412', 'CSCE 416', 'CSCE 456', 'CSCE 461',
                  'CSCE 462', 'CSCE 463', 'CSCE 464', 'CSCE 465', 'CSCE 469', 'CSCE 429', 'CSCE 430', 'CSCE 431', 'CSCE 434',
                  'CSCE 435', 'CSCE 438', 'CSCE 451', 'CSCE 310', 'CSCE 320', 'CSCE 420', 'CSCE 421', 'CSCE 436', 'CSCE 441',
                  'CSCE 443', 'CSCE 444', 'CSCE 445', 'CSCE 446', 'CSCE 447', 'CSCE 452', 'CSCE 470']

  @yes_no = ['Yes', 'No']

  @ratings = ['1', '2', '3', '4', '5']

  @electiveMap = {'CSCE 411' => 'Algorithms', 'CSCE 433' => 'Natural Language Processing,Algorithms', 'CSCE 440' => 'Algorithms',
                  'CSCE 442' => 'Algorithms', 'CSCE 410' => 'Operating Systems,Computer Architecture', 'CSCE 412' => 'Cloud Computing,Networking',
                  'CSCE 416' => 'Computer Architecture', 'CSCE 456' => 'Networking,Operating Systems', 'CSCE 461' => 'Robotics',
                  'CSCE 462' => 'Computer Architecture,Operating Systems', 'CSCE 463' => 'Networking,Parallel Computing',
                  'CSCE 464' => 'Networking,Cybersecurity', 'CSCE 465' => 'Cybersecurity', 'CSCE 469' => 'Computer Architecture',
                  'CSCE 429' => 'Software Engineering', 'CSCE 430' => 'Software Engineering', 'CSCE 431' => 'Software Engineering',
                  'CSCE 434' => 'Compiler Theory', 'CSCE 435' => 'Parallel Computing', 'CSCE 438' => 'Parallel Computing',
                  'CSCE 451' => 'Compiler Theory,Algorithms', 'CSCE 310' => 'Database Systems', 'CSCE 320' => 'Data Science',
                  'CSCE 420' => 'Artificial Intelligence,Machine Learning', 'CSCE 421' => 'Machine Learning,Artificial Intelligence',
                  'CSCE 445' => '', 'CSCE 444' => '',
                  'CSCE 436' => 'Human Computer Interaction', 'CSCE 441' => 'Computer Graphics', 'CSCE 443' => 'Computer Graphics,Human Computer Interaction',
                  'CSCE 446' => 'Computer Graphics', 'CSCE 447' => 'Data Science', 'CSCE 452' => 'Robotics', 'CSCE 470' => 'Data Science,Database Systems'}

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

  def self.ratings
    return @ratings
  end

  def self.get_id
    return self.id
  end

  def self.electiveMap
    return @electiveMap
  end
end
