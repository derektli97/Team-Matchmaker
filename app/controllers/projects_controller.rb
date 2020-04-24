class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(section_id: params[:section_id])
    @manual_assignment = []
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @students = Student.where(project_id: params[:id])
  end

  # GET /projects/new
  def new
    @all_project_tags = Project.all_project_tags

    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @all_project_tags = Project.all_project_tags
    @topics = @project.topics
    @client = @project.client
  end

  # POST /projects
  # POST /projects.json
  def create
    # Add selected tags to the topics variable of a project
    if !params[:tags].nil?
      session[:tags] = params[:tags]
    end

    if !session[:tags].nil? && params[:tags].nil?
      new_hash = {}
      new_hash[:tags] = session[:tags]
      redirect_to new_section_project(new_hash)
    end

    @selected_tags = params[:tags] if params.key?(:tags)

    if @selected_tags != nil
      params[:project].merge!(:topics => @selected_tags.join(','))
    end

    @project = Project.new(project_params)
    @project.section_id = params[:section_id]

    respond_to do |format|
      if @project.save
        format.html { redirect_to section_projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    # Add selected tags to the topics variable of a project
    @selected_tags = params[:tags] if params.key?(:tags)

    if @selected_tags != nil
      params[:project].merge!(:topics => @selected_tags.join(','))
    end

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to section_projects_path(:section_id => @project.section_id), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to section_projects_path, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def match
    puts "-------------------------------"
    puts "START OF MATCH ALG"
    puts "-------------------------------"
    students = Student.where(section_id: params[:section_id])
    projects = Project.where(section_id: params[:section_id])
    available_students = []
    available_projects = []
    student_assignments = {}
    project_assignments = {}
    max_global_score = -10000
    final_assignments = {}
    bad_matches = []
    
    
    
    ###### Compute Student Scores for each project ########
    
    student_scores = {}
    students.each do |student|
      available_students.push(student.id)
      student_scores[student.id] = {}
      projects.each do |project|
        available_projects.push(project.id)
        project_assignments[project.id] = []
        score = 0
        score_hash = {}
        preferences = student.preferences.split(',')
        preferences.each do |p|
          split_preferences = p.split('.')
          rating = split_preferences[1].to_i
          case rating
          when 5
            score += 20
          when 4
            score += 10
          when 3
            score += 5
          end
        end
        intersecting_topics = (project.topics.split(',')) & (student.topics.split(','))
        score += intersecting_topics.length()*10
        electives = student.electives.split(',')
        #puts electives
        elective_map = Student.electiveMap
        tags = []
        electives.each do |e|
          tags << elective_map[e].split(',')
        end
        tags = tags.flatten.uniq
        intersecting_electives = tags & project.topics.split(',')
        score += intersecting_electives.length()*5 
        score_hash[project.id] = score
        student_scores[student.id].merge!(score_hash)
      end
    end
    
    #puts student_scores
    
    ############# End Compute of Student Scores ################
    
    available_projects = available_projects.uniq
    available_projects_copy = available_projects.deep_dup
    available_students_copy = available_students.deep_dup
    project_assignments_copy = project_assignments.deep_dup
    student_assignments_copy = student_assignments.deep_dup
    #puts available_projects_copy.to_s
    
    
    (0..10).each do 
      #################### Initial Assignment #####################
      
      while(!available_students.empty?)
        s = available_students.sample(1)[0]
        #puts s
        score_set = student_scores[s]
        #puts score_set
        max_score = score_set.max_by{|k,v| v}
        # puts max_score[1]
        best_project = []
        while(best_project.length() == 0)
          score_set.each do |p_id,score|
            if(score == max_score[1])
              best_project.push(p_id)
            end
          end
          best_project = best_project & available_projects
          #puts "Student ID: " + s.to_s + " Best Projects: " + best_project.to_s
          max_score[1] -= 5
        end
        available_students.delete(s)
        assignment = best_project.sample(1)[0]
        student_assignments[s] = assignment
        project_assignments[assignment].push(s)
        #puts "Assigned Project: " + student_assignments[s].to_s
        max_group_size = Project.find(assignment).max_group_size
        puts "Current Size: " + project_assignments[assignment].length().to_s
        puts "Max Size: " + max_group_size.to_s
        if(project_assignments[assignment].length() == max_group_size)
          puts assignment.to_s + " is being removed from the pool"
          available_projects.delete(assignment)
        end
        puts "Available Students: " + available_students.to_s
        puts "Available Projects: " + available_projects.to_s
        puts ""
      end
      
      ##################### End Initial Assignment #######################
      
      # puts student_assignments.sort.to_h
       puts project_assignments.sort.to_h
      
      project_assignments.each do |project,students|
        p = Project.find(project)
        if(students.length() == 0)
          available_projects.delete(project)
        elsif(students.length() < p.min_group_size)
          available_students = available_students.push(students)
        end
      end
      available_projects = available_projects.uniq
      available_students = available_students.flatten
      # project_assignments.each do |project,students|
      #   p = Project.find(project)
      #   if(available_students.length() < p.min_group_size)
      #     available_projects.delete(project)
      #   end
      # end
      
      puts project_assignments
      puts "Available Students: " + available_students.to_s
      puts "Available Projects: " + available_projects.to_s
      
      count = 0
      while(!available_students.empty? && count < 10)
        s = available_students.sample(1)[0]
        score_set = student_scores[s]
        #puts score_set
        max_score = 0
        best_project = 0
        available_projects.each do |project|
          if(score_set[project] > max_score[1])
            max_score = score_set[project]
            best_project = project
          end
        end
        available_students.delete(s)
        assignment = best_project
        student_assignments[s] = assignment
        #puts project_assignments
        project_assignments[assignment].push(s)
        # puts "Assigned Project: " + student_assignments[s].to_s
        # puts "Current Size: " + project_assignments[assignment].length().to_s
        max_group_size = Project.find(assignment).max_group_size
        puts "Max Size: " + max_group_size.to_s
        if(project_assignments[assignment].length() == max_group_size)
          # puts assignment.to_s + " is now FULL"
          available_projects.delete(assignment)
        end
        puts "Available Students: " + available_students.to_s
        puts "Available Projects: " + available_projects.to_s
        puts ""
        if(available_students.empty?)
          project_assignments.each do |project,students|
            p = Project.find(project)
            if(students.length() == 0)
              available_projects.delete(project)
            elsif(students.length() < p.min_group_size)
              available_students = available_students.push(students)
              project_assignments[project] = []
            elsif(students.length() < p.max_group_size && students.length() > p.min_group_size)
              puts project.to_s + " NOT FULL"
              puts students.length()
              available_projects.push(project)
            end
          end
          available_projects = available_projects.uniq
          available_students = available_students.flatten
          puts available_projects.to_s
          # project_assignments.each do |project,students|
          #   p = Project.find(project)
          #   if(available_students.length() < p.min_group_size)
          #     available_projects.delete(project)
          #   end
          # end
          puts project_assignments
          puts "Available Students: " + available_students.to_s
          puts "Available Projects at end of leftovers: " + available_projects.to_s
        end
        count += 1
      end
      
      puts student_assignments.sort.to_h
      puts project_assignments
      puts "Available Students: " + available_students.to_s
      puts "Available Projects: " + available_projects.to_s
      
      #################### Compute Score #################
      #puts max_global_score
      #puts student_scores
      total_score = 0
      student_assignments.each do |student,project|
        total_score += student_scores[student][project]
      end
      project_assignments.each do |project,students|
        p = Project.find(project)
        hardware_match = false
        if(p.hardware)
          students.each do |stud|
            s = Student.find(stud)
            if(s.hardware)
              hardware_match = true
            end
          end
        end
        if(hardware_match)
          total_score += 300
        end
      end
      total_score -= available_students.length()*10
      puts "Total Score: " + total_score.to_s
      #puts "Global Score: " + max_global_score.to_s
      if(total_score > max_global_score)
        #puts "New Score Assigned"
        max_global_score = total_score
        final_assignments = student_assignments
      end
      
      ####################### Reset #######################
      bad_matches = available_students.deep_dup
      puts "Bad matches: "
      puts bad_matches.to_s
      @manual_assignment = []
      bad_matches.each do |s|
        @manual_assignment.push(Student.find(s))
      end
      student_assignments = student_assignments_copy.deep_dup
      project_assignments = project_assignments_copy.deep_dup
      available_projects = available_projects_copy.deep_dup
      available_students = available_students_copy.deep_dup
      #puts available_projects.to_s
      #puts available_students.to_s
      
      
    end
    puts ""
    puts ""
    
    puts "Final Score: " + max_global_score.to_s
    
    puts "Final Assignment:" 
    puts final_assignments.sort.to_h
    puts "Bad matches: "
    puts bad_matches
    
    final_assignments.each do |_id,project|
      student = Student.find(_id)
      student.project_id = project
      student.save
    end
    
    puts "-------------------------------"
    puts "END OF MATCH ALG"
    puts "-------------------------------"
    
    redirect_to section_projects_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, :max_group_size, :min_group_size, :topics, :hardware, :industry_sponsored, :client)
    end
    
end
