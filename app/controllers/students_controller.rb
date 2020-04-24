class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @all_project_tags = Student.all_project_tags
    @genders = Student.genders
    @ethnicities = Student.ethnicities
    @electives = Student.electives
    @yes_no = Student.yes_no
    @ratings = Student.ratings

    @projects = Project.where(section_id: params[:section_id])

    @student = Student.new
  end

  # GET /students/1/edit
  def edit

  end

  # POST /students
  # POST /students.json
  def create
    @all_project_tags = Student.all_project_tags
    @genders = Student.genders
    @ethnicities = Student.ethnicities
    @electives = Student.electives
    @yes_no = Student.yes_no
    @projects = Project.where(section_id: params[:section_id])

    student_gender = params[:gender]
    student_hardware = params[:hardware]
    student_ethnicity = params[:ethnicity]
    selected_tags = params[:tags]
    student_electives = params[:electives]
    student_preferences = []

    params[:student].merge!(:gender => student_gender, :ethnicity => student_ethnicity, :topics => selected_tags.join(','),
                            :electives => student_electives.join(','), :section_id => params[:section_id], :project_id => nil)

    if student_hardware == "Yes"
      params[:student].merge!(:hardware => true)
    elsif student_hardware == "No"
      params[:student].merge!(:hardware => false)
    end

    @projects.each do |project|
      student_preferences.push('(' + project.id.to_s + ':' + params[project.title] + ')')
    end

    params[:student].merge!(:preferences => student_preferences.join(','))

    @student = Student.new(student_params)

    @student.section_id = params[:section_id]
    @student.project_id = nil

    respond_to do |format|
      if @student.save
        format.html { redirect_to section_students_path, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :email, :gender, :ethnicity, :topics, :hardware, :electives, :preferences, :section_id, :project_id)
    end
end
