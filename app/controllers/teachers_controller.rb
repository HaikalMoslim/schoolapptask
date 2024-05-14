class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action :authorize_teacher, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @teachers = Teacher.all
    @teachers = @teachers.search(params[:query]) if params[:query].present?
    @pagy, @teachers = pagy @teachers.reorder(sort_column => sort_direction), items: params.fetch(:count,10)
  end

  def sort_column
    %w{id name}.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w{asc desc}.include?(params[:direction]) ? params[:direction] : "asc"
  end

  def show
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      update_user_name(@teacher, teacher_params[:name])
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
    params.require(:teacher).permit(:name, :about, :school_id)
  end

  def authorize_teacher
    redirect_to teachers_path, alert: "You are not authorized to perform this action" unless @teacher.user == current_user || current_user.admin?
  end

  def update_user_name(teacher, new_name)
    teacher.user.update(name: new_name) if teacher.user.present?
  end
end
