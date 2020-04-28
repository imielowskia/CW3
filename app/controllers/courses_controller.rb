class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy], except: [:sabc, :scba]
  protect_from_forgery except: [:show, :sabc, :scba]


  # GET /courses
  # GET /courses.json
  def index

    @courses = Course.all
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

  # GET /courses/sabc
  #sortowanie indexu abc
  def sabc
    @courses = Course.order(name: :asc).all

   respond_to do |format|
     format.js
   end

  end

  # GET /courses/scba
  # sortowanie indexu abc
  def scba
    @courses = Course.order(name: :desc).all

    respond_to do |format|
      format.js
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
