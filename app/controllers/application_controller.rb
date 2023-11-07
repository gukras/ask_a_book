class ApplicationController < ActionController::Base 
    unless Rails.application.config.consider_all_requests_local
        rescue_from Exception, with: :render_error
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
        rescue_from ActionController::RoutingError, with: :render_not_found
    end      
    
    
    protected
  
    def after_sign_in_path_for(resource)
        '/db' 
    end

    private
      
    def render_not_found(exception)
        render template: 'errors/not_found', status: 404
    end
    
    def render_error(exception)
        render template: 'errors/internal_server_error', status: 500
    end
end
