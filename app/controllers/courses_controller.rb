class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :show


  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  #sortowanie rosnące
  def az
    @courses = Course.order(name: :asc).all
    respond_to :js
  end

  #sortowanie malejące
  def za
    @courses = Course.order(name: :desc).all
    respond_to :js
  end

  # zapisy na listę
  # GET /courses/1/list
  def list
    xcourse_id = params[:id].to_i
    @course = Course.find(xcourse_id)
    @xstudents = Student.all
  end

  # dodawanie do kursu
  # GET /courses/1/append/1
  def append
    xcourse_id = params[:id].to_i           # id kursu
    xstudent_id = params[:student_id].to_i  # id studenta
    studentadd = CourseStudent.new
    studentadd.student_id = xstudent_id
    studentadd.course_id = xcourse_id
    studentadd.save!
    @course = Course.find(xcourse_id)
    @xstudents = Student.all
    respond_to :js

  end

  # usuwanie z kursu
  # GET /courses/1/remove/1
  def remove
    xcourse_id = params[:id].to_i           # id kursu
    xstudent_id = params[:student_id].to_i  # id studenta
    xcs = CourseStudent.where(course_id: xcourse_id, student_id: xstudent_id).first
    xcs.destroy!
    @course = Course.find(xcourse_id)
    @xstudents = Student.all
    respond_to :js
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    xid = params[:id].to_i
    @course = Course.find(xid)
  end

  #POST /courses/oceny
  #akcja kontrolera do zapisu ocen z "show"
  def oceny
    xcourse = params[:oceny][:course_id]
    CourseStudent.where(course_id: xcourse.to_i).each do |g|
      #xs_id = g.student_id
      g.grade = params['grade_'+g.student_id.to_s]
      g.save!
    end
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully updated.' }
      format.json { render :show, status: :ok, location: @course }
    end
  end


  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_url, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_url, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :ects, student_ids: [])
    end
end
