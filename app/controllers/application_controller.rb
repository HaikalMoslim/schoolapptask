class ApplicationController < ActionController::Base
  include Pagy::Backend
    def after_sign_in_path_for(resource)
      if resource.is_a?(User)
        if resource.admin?
          homes_path
        elsif resource.student?
          homes_path
        elsif resource.teacher?
          homes_path
        else
          root_path
        end
      else
        super
      end
    end
end