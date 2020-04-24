class Project < ApplicationRecord
    #belongs_to :section
    @all_project_tags = ['Algorithms', 'Artificial intelligence', 'Compiler Theory', 'Computer Architecture', 'Computer Graphics', 'Cryptography', 
    'Cybersecurity', 'Data Structures', 'Data Science', 'Database Systems', 'Human Computer Interaction', 'Machine Learning', 
    'Natural Language Processing', 'Networking', 'Operating Systems', 'Parallel Computing', 'Programming Languages', 'Robotics', 'Software Engineering']
    
    @manual_assignment = []

    def self.all_project_tags
        return @all_project_tags
    end
    def self.get_project_tags
        return self.topics
    end
    def self.manual_assignment
        return @manual_assignment
    end
    def self.clear
        @manual_assignment.clear
    end
end
