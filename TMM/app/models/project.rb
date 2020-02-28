class Project < ActiveRecord::Base
    
    #instance variable for the project model
    @title = NULL
    @description = NULL
    
    @max_group_size = NULL
    @min_group_size = NULL
    @topics = NULL
    @course_work = NULL
    
    @hardware = NULL
    @industry_sponsored = NULL
    @client = NULL
    
    @students = NULL
    
    def initialize(title, description, max_group_size, min_group_size, topics, course_work, hardware, industry_sponsored, client, students)
        #constructor
        @title = title
        @description = description
        @max_group_size = max_group_size
        @min_group_size = min_group_size
        @topics = topics
        @course_work = course_work
        @hardware = hardware
        @instustry_sponsored = industry_sponsored
        @client = client
        @students = NULL #Null for right now will be changed to a container later
    end
    
    #getter and setter methods
    def title
        @title
    end
    def description
        @description
    end
    def max_group_size
        @max_group_size
    end
    def min_group_size
        @min_group_size
    end
    def topics
        @topics
    end
    def course_work
        @course_work
    end
    def hardware
        @hardware
    end
    def industry_sponsored
        @industry_sponsored
    end
    def client
        @client
    end
    def students
        @students
    end
    def students=(list)
        @students = list
    end
end