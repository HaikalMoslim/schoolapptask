class HomesController < ApplicationController
  def index
    @enrollment_count = Enrollment.count
    @fee_count = Fee.count
    @payment_count = Payment.count
    @school_count = School.count
    @student_count = Student.count
    @teacher_count = Teacher.count
    @user_count = User.count
  end
end
