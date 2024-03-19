class TeachersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action :authorize_teacher, only: [:edit, :update, :destroy]

  def index
    @teachers = Teacher.all
  end

  def show
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: 'Teacher was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher.destroy
    redirect_to teachers_path, notice: 'Teacher was successfully deleted.'
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:name)
  end

  def authenticate_user!
    redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
  end

  def authorize_teacher
    redirect_to teachers_path, alert: "You are not authorized to perform this action" unless @teacher.user == current_user
  end
end
