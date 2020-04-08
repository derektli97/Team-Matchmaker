class Project < ApplicationRecord
    #belongs_to :section
    @all_project_tags = ['AI', 'ML', 'Networking', 'Operating Systems', 'Cloud Computing', 'Cyber Security', 'Data Science',
                         'Web Development', 'Graphics', 'Robotics', 'Algorithm Theory']

    def self.all_project_tags
        return @all_project_tags
    end
    def self.get_project_tags
        return self.topics
    end
end
