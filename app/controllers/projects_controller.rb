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
    hardware_students = Student.where(section_id: params[:section_id], hardware: true)
    hardware_projects = Project.where(section_id: params[:section_id], hardware: true)

    hardware_students.each do |s|
      preferences = s.preferences.split(',')
      tuplePrefs = []

      preferences.each do |p|
        tuplePrefs.push(Tuple(p.split('.')))
      end

      matchScore = {:score => 0, :p_id => nil}
      tuplePrefs.each do |tup|
        if tup[1].to_i < 3
          next
        end

        hardware_projects.each do |p|
          if p.id == tup[0].to_i
            score = 0
            p_topics = p.topics.split(',')
            s_topics = s.topics.split(',')

            common_topics = p_topics.intersection(s_topics)

            score += common_topics.length() * 10

            s_electives = s.electives.split(',')
            electiveMap = Student.electiveMap

            tags = []
            s_electives.each do |e|
              tags.push(electiveMap[e].split(','))
            end

            tags = tags.flatten.uniq

            common_topics = p_topics.intersection(tags)

            score += common_topics.length() * 5

            if score > matchScore[:score]
              matchScore[:score] = score
              matchScore[:p_id] = p.id
              s.project_id = matchScore[:p_id]
            end
          end
        end

        projects.each do |p|
          if p.id == tup[0].to_i
          end
      end
    end

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
