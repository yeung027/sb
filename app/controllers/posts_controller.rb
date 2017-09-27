class PostsController < ApplicationController
    layout "backend", except: [:index, :show]
    before_action :authenticate_user#, except: [:index, :show]
    
    def index
        #@post = Post.find_by_id(5)
        
        #@post.destroy
        #render :plain =>@post.featured?
        #render :plain =>"ok"
    end
    
    def new
        @post   = Post.new
        new_create_vars
    end
    
    def create
        @post   = Post.new(post_params)
        @post.user  = User.find_by_id(session[:user_id])
        if !@post.save
            new_create_vars
            render 'new'
        else
            flash[:notice]  = "Create post success!"
            redirect_to @post
        end
    end
    
    def show        
        @post   = Post.find_by_id(params[:id])
        if @post.nil?
            redirect_to root_path
            return
        end
        render :layout => 'application'
    end
    
    def edit
        @post   = Post.find_by_id(params[:id])
        if @post.nil?
            redirect_to root_path
            return
        end
        edit_update_vars
    end
    
    def update
        @post   = Post.find_by_id(params[:id])
        if !@post.update(post_params)
            edit_update_vars
            render 'edit'
        else
            flash[:notice]  = "Post updated!"
            redirect_to @post
        end
    end#end update
    
    def destroy
        @post   = Post.find_by_id(params[:id])
        if @post.destroy
            flash[:notice]  = "Post deleted!"
            redirect_to root_path
        else
            edit_update_vars
            render 'edit'
        end
    end
    
    
    private
    def post_params
        params.require(:post).permit(:title, :content, :featured, :small_image, :featured_image)
    end
    
    def new_create_vars
        @submit_label   = "Create"
        @submit_path    = posts_path
        @method         = "post"
    end
    
    def edit_update_vars
        @submit_label   = "Save"
        @submit_path    = post_path(@post)
        @method         = "patch"
    end
end
