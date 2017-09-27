class UsersController < ApplicationController
    
   # layout "backend_users_login", only: [:login]
    layout "backend", except: [:login, :auth, :logout]
    before_action :authenticate_user, except: [:login, :auth, :logout]
    def index
        @users = User.all.paginate(:page => params[:page])
    end
    
    def login
        if has_login? 
            redirect_to users_path
            return
        end
        
        if session[:invalid_id_or_password]
            session.delete(:invalid_id_or_password)
            @box_class  = "shake"
        end
        render :layout => 'backend_users_login'
    end

    def auth
        @users   = User.where("login= ? and password = ?", user_params[:login] , user_params[:password])
        
        if @users.count>0
            session[:user_id] = @users.first.id
            update_admin_session_expires_time
            redirect_to users_path
        else 
            flash[:error] = "Invalid login or password, please try again."
            session[:invalid_id_or_password] = true
            redirect_to login_users_path()
        end
    
    end
    
    def logout
        session.delete(:user_id)
        redirect_to login_users_path
    end
    
    def show
        @user   = User.find_by_id(params[:id])
    end
    
    def new
        @user   = User.new
        new_create_vars
    end
    
    def create
        @user   = User.new(user_params)
        if !confirm_is_match_with_password?
            @confirm_not_match   = true
        end
        if @confirm_not_match || !@user.save
            if @confirm_not_match
                add_error_confirm_is_not_match_with_password
            end
            new_create_vars
            render 'new'
        else
            flash[:notice]  = "Create user success!"
            redirect_to @user
        end
    end
    
    def edit
        @user   = User.find_by_id(params[:id])
        edit_update_vars
    end
    
    def update
        @user   = User.find_by_id(params[:id])
        if !confirm_is_match_with_password?
            @confirm_not_match   = true
        end
        if @confirm_not_match || !@user.update(user_params)
            if @confirm_not_match
                add_error_confirm_is_not_match_with_password
            end
            edit_update_vars
            render 'edit'
        else
            flash[:notice]  = "User updated!"
            redirect_to @user
        end
    end#end update
    
    private
    def user_params
        params.require(:user).permit(:login, :password, :name)
    end
    
    def new_create_vars
        @submit_label   = "Create"
        @submit_path    = users_path
        @method         = "post"
    end
    
    def edit_update_vars
        @submit_label   = "Save"
        @submit_path    = user_path(@user)
        @method         = "patch"
    end
    
    def confirm_is_match_with_password?
        params[:user][:confirm_password]==params[:user][:password]
    end
    
    def add_error_confirm_is_not_match_with_password
        @user.errors.add(:confirm_password, "is not match with password.")
    end
    
    def save_user_and_check_error
    end
end
