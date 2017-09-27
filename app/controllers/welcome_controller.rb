class WelcomeController < ApplicationController
    before_action :authenticate_user#, except: [:index, :show]
    def index
       # @pet = Pet.find_by_id(1387)
      # @pet.calculate_ranking
        
        
        #average_hp   = Ranking.where("pet_id = ?", 1387).average(:hp)
        
        #wow = Ranking.where("pet_id = ? AND ip = ?", 1387, request.remote_ip).count
        
        #render :plain => wow
        #return
        
        
        #@user = User.first
      
      #@ok   = Post.first
      #@ok    = Post.new
      #@ok.title="welcome"
      #@ok.content="nghjio gioj of"
      #@ok.save
      #@ok.user  = @user
      ##
      #render :plain => "yeah"
      #render :plain => @ok.attributes
      @posts = Post.order(:updated_at).all
      @pets = Pet.order("created_at DESC").limit(10)
      
      @left_featured_post           = Post.where(featured: Post.featured_types["Left"]).order(:updated_at).first
      @right_top_featured_post      = Post.where(featured: Post.featured_types["RightTop"]).order(:updated_at).first
      @right_bottom_left_featured_post = Post.where(featured: Post.featured_types["RightBottomLeft"]).order(:updated_at).first
      @right_bottom_right_featured_post = Post.where(featured: Post.featured_types["RightBottomRight"]).order(:updated_at).first
      #render :plain => @left_featured_post.featured == Post.featured_types["Right Top"]
      #render :plain => Post.featured_types["None"]
      #@left_featured_post.featured
    end
end
