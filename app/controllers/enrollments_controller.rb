class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @enrollments = Enrollment.all
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to enrollments_path, notice: 'Enrollment was successfully created.'
    else
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
    params.require(:enrollment).permit(:student_id, :teacher_id)
  end

  def authenticate_user!
    redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
  end
end
