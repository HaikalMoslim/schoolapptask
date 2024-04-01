# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    protected
  
    def after_sign_in_path_for(resource)
      if resource.is_a?(User)
        if resource.admin?
          students_path
        elsif resource.student?
          students_path
        elsif resource.teacher?
          teachers_path
        else
          # Redirect to another path for other user types if needed
          root_path
        end
      else
        super
      end
    end
end