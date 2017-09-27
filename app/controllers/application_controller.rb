class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    helper_method :has_login?, :is_admin?, :get_user
    
    def has_login?
        !(session[:user_id].nil? || session[:user_id_expires_at] < Time.current)
    end
    
    def is_admin?
        @user   = User.find_by_id(session[:user_id])
        if !has_login? || @user.nil?
            return false 
        end
        return @user.is_admin?
    end
    
    def get_user
        if !has_login?
            return nil
        end
        return User.find_by_id(session[:user_id])
    end
    
    def authenticate_user
        if session[:user_id].nil?
            flash[:error] = "Please login and try again."
            redirect_to login_users_path
        elsif session[:user_id_expires_at] < Time.current
            flash[:error] = "Your login session expired, please login again."
            session.delete(:user_id)
            redirect_to login_users_path
        else
            update_admin_session_expires_time
        end
    end
    
    def update_admin_session_expires_time
        session[:user_id_expires_at] = Time.current + 30.minute
    end
    
    def is_same_with_japanese_nothing(str)
        return str == 'なし'
    end
    
    def add_visit_record
        if request.remote_ip == '127.4.180.1'
            return
        end
        visitor     = Visitor.new
        visitor.ip  = request.remote_ip
        visitor.url = request.url
        visitor.controller  = params[:controller]
        visitor.action      = params[:action]
        if has_login?
            visitor.user_id    = session[:user_id]
        end
        visitor.save!
    end
    
    
    
end
