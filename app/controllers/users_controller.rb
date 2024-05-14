class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @users = @users.search(params[:query]) if params[:query].present?
    @pagy, @users = pagy @users.reorder(sort_column => sort_direction), items: params.fetch(:count,2)
  end

  def sort_column
    %w{name email role}.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w{asc desc}.include?(params[:direction]) ? params[:direction] : "asc"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      update_associated_records(@user)
      redirect_to users_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User deleted successfully."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_associated_records(user)
    if user.role == 'student'
      student = user.student
      student.update(name: user.name) if student
    elsif user.role == 'teacher'
      teacher = user.teacher
      teacher.update(name: user.name) if teacher
    end
  end
end
