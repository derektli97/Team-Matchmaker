class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(section_id: params[:section_id])
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    #@students = Students.where(project_id: params[:id])
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
    students = Student.where(section_id: params[:section_id])
    projects = Project.where(section_id: params[:section_id])
    
    #puts students.length()
    
    student_pool = {}
    available_students = []

    students.each do |student|
      preferences = student.preferences.split(',')
      #puts "|||STUDENT ID|||" + student.id.to_s
      #puts preferences
      available_students << student.id
      preferences.each do |p|
        pref_parse = p.split('.')
        temp_array = student_pool[pref_parse[0]]
        if(temp_array == nil)
          temp_array = [student.id]
        else
          temp_array << student.id
        end
        student_pool[pref_parse[0]] = temp_array
      end
    end

    student_pool.each do |key, val|
      p = Project.where(id: key)
      min_size = p[0].min_group_size
      if(val.length() < min_size)
        student_pool.delete(key)
      end
    end
    
    student_pool = student_pool.sort_by{|k,v| v.length()}.to_h
    puts student_pool
    #puts available_students

    assignment_hash = {}
    target_project_scores = {}

    student_pool.each do |project_key, pool|
      student_num = 0
      assignment_hash[project_key] = []
      p = Project.find(project_key.to_i)
      if((available_students & pool).length()  < p.min_group_size)
        assignment_hash.delete(project_key)
        next
      end

      max_score = p.min_group_size*20 + p.topics.split(',').length()*15
      target_project_scores[p.id] = 0.8*max_score
      
      prev_r = -1
      while(student_num < p.min_group_size)
        r = rand(0..(pool.length()-1))
        if(r == prev_r)
          next
        end
        prev_r = r
        rand_student = pool[r]
        #puts available_students
        if(available_students.include?(rand_student))
          #puts "Project ID: " + project_key.to_s + " " + rand_student.to_s
          available_students.delete(rand_student)
          assignment_hash[project_key].push(rand_student)
          pool.delete(rand_student)
          student_num += 1
          #puts student_num
        end
        if(available_students.empty?)
          break
        end
      end
    end
    
    puts assignment_hash
    puts available_students
    
    available_students.each do |student|
      s = Student.find(student)
      prefs = s.preferences.split(',')
      prefs.each do |pref|
        ratings = pref.split('.')
        if(ratings[1].to_i == 5 && assignment_hash.include?(ratings[0]))
          assignment_hash[ratings[0]].push(student)
          break
        end
      end
    end
    
    puts available_students
    puts assignment_hash
    puts target_project_scores

    assignment_hash.each do |_project_id, _students|
      project = Project.find(_project_id.to_i)
      score  = 0
      student_hardware = false
      _students.each do |student|
        s = Student.find(student)
        prefs = s.preferences.split(',')
        prefs.each do |pref|
          ratings = pref.split('.')

          if(ratings[0].to_i == project.id)
            case ratings[1].to_i
            when 5
              score += 20
            when 4
              score += 10
            when 3
              score += 5
            end
          end
        end

        intersecting_topics = (s.topics.split(',')) & (project.topics.split(','))
        score += intersecting_topics.length()*10
        puts "Intersecting topics: " + intersecting_topics.to_s
        electives = s.electives.split(',')
        #puts electives
        elective_map = Student.electiveMap
        tags = []
        electives.each do |e|
          tags << elective_map[e].split(',')
        end
        tags = tags.flatten.uniq
        intersecting_electives = tags & project.topics.split(',')
        score += intersecting_electives.length()*5
        puts "Intersecting electives" + intersecting_electives.to_s
        
        if(s.hardware)
          student_hardware = true
        end

      end
      
      if(project.hardware && !student_hardware)
        score = 0
      end

      puts _project_id + ": " + score.to_s

    end

    #puts student_pool
    puts "End of match algorithm"

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
