class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :authorize_student, only: [:edit, :update, :destroy]

  def index
    @students = Student.all
  end

  def show
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    redirect_to root_path, notice: 'Student was successfully deleted.'
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name)
  end

  def authenticate_user!
    redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
  end

  def authorize_student
    redirect_to root_path, alert: "You are not authorized to perform this action" unless @student.user == current_user
  end
end
