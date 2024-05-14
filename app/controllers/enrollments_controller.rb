class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @enrollments = Enrollment.all
    @enrollments = @enrollments.search(params[:query]) if params[:query].present?
    @pagy, @enrollments = pagy @enrollments.reorder(sort_column => sort_direction), items: params.fetch(:count,10)
  end

  def sort_column
    # Determine if sorting parameter is valid
    sortable_columns = %w[student_name teacher_name]
    sort = sortable_columns.include?(params[:sort]) ? params[:sort] : nil
  
    if sort.present?
      case sort
      when 'student_name'
        # Join with students table and sort by student name
        'students.name'
      when 'teacher_name'
        # Join with teachers table and sort by teacher name
        'teachers.name'
      end
    else
      # Default sorting column
      'created_at'
    end
  end

  def sort_direction
    %w{asc desc}.include?(params[:direction]) ? params[:direction] : "asc"
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)

    student = Student.find(@enrollment.student_id)
    teacher = Teacher.find(@enrollment.teacher_id)

    if student.school_id == teacher.school_id
      if @enrollment.save
        redirect_to enrollments_path, notice: 'Enrollment was successfully created.'
      else
        flash.now[:alert] = 'Error creating enrollment.'
        render :new
      end
    else
      flash.now[:alert] = 'Student and teacher must belong to the same school.'
      render :new
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    @enrollment.destroy
    redirect_to @enrollment
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:student_id, :teacher_id, :class_name)
  end

  # def authenticate_user!
  #   redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
  # end
end
