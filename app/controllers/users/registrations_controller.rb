class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      case @user.role
      when 'admin'
        redirect_to students_path, notice: 'Admin was successfully created.'
      when 'student'
        Student.create(user: @user, name: @user.name)
        redirect_to user_session_path, notice: 'Student was successfully created.'
      when 'teacher'
        Teacher.create(user: @user, name: @user.name)
        redirect_to user_session_path, notice: 'Teacher was successfully created.'
      else
        redirect_to root_path, notice: 'User was successfully created.'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
  end
end
