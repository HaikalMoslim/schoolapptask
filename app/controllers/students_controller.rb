class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :authorize_student, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @students = Student.all
    @students = @students.search(params[:query]) if params[:query].present?
    @pagy, @students = pagy @students.reorder(sort_column => sort_direction), items: params.fetch(:count,10)
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
    if @student.update(student_params)
      update_user_name(@student, student_params[:name])
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
    params.require(:student).permit(:name, :about, :school_id)
  end

  def authorize_student
    redirect_to root_path, alert: "You are not authorized to perform this action" unless @student.user == current_user || current_user.admin?
  end

  def update_user_name(student, new_name)
    student.user.update(name: new_name) if student.user.present?
  end
end
