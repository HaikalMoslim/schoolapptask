class TeachersController < ApplicationController
    before_action :authenticate_user!

  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to @teacher, notice: 'Teacher was successfully created.'
    else
      render :new
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])

    if @teacher.update(teacher_params)
      redirect_to @teacher
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to @teacher
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name)
  end

  def authenticate_user!
    redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
  end
end
