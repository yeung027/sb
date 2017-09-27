class PetsController < ApplicationController
    layout "backend", except: [:index, :show]
    before_action :authenticate_user, except: [:index, :show, :search]
    before_action :add_visit_record, only: [:index, :show]
    
    def index
       # if request.referer.nil?
       #     @pets   = Pet.all
       # end
        #@os = get_operating_system
        @title  = "Summons Board 召喚圖板圖鑑"
    end
    
    def search
        @pets   = Pet#.select("id, name, number")
        if !pet_params[:number].empty?
            @pets   = @pets.where("number = ? OR name LIKE ? OR chinese_name LIKE ?", pet_params[:number], "%"+pet_params[:number]+"%", "%"+pet_params[:number]+"%")
        end
        
        if !pet_params[:pet_attribute].empty?
            @pets   = @pets.where("pet_attribute = ?", pet_params[:pet_attribute])
        end
        
        if !pet_params[:type1].empty?
            @pets   = @pets.where("type1 = ?", pet_params[:type1])
        end
        
        if !pet_params[:type2].empty?
            @pets   = @pets.where("type2 = ?", pet_params[:type2])
        end
        
        @pets   = @pets.all
        
        @result = @pets.to_json(:only => [:id,:name,:number], :methods => [:get_profile_image])
        
        #render :plain => @pets.count
        #return
        #render :plain => @pets.as_json
        
        respond_to do |format|
            #format.html
            format.json { render :json => @result }
        end
    end
    
    def new
        @pet   = Pet.new
        if !params[:number].nil?
            @pet.number =  params[:number]
        end
        
        new_create_vars
    end
    
    def create
        @pet   = Pet.new(pet_params)
        if !@pet.save
            new_create_vars
            render 'new'
        else
            flash[:notice]  = "Create pet success!"
            redirect_to pet_path(@pet.number)
        end
    end
    
    def show  
        #@os = get_operating_system
        @pet   = Pet.find_by_number(params[:number])
        if @pet.nil?
            redirect_to root_path
            return
        end
        
        if !@pet.chinese_name.nil? && !@pet.chinese_name.empty?
            @title  = @pet.name+"("+@pet.chinese_name+") Summons Board 召喚圖板 圖鑑"
        else
            @title  = @pet.name+" Summons Board 召喚圖板 圖鑑"
        end
        if !@pet.before_evolution_pet.nil?
            @before_evolution   = Pet.find_by_number(@pet.before_evolution_pet.number)
        end
        
        if !@pet.after_evolution_pet.nil?
            @after_evolution   = Pet.find_by_number(@pet.after_evolution_pet.number)
        end
        
        if !@pet.active_skill_name.nil? && !is_same_with_japanese_nothing(@pet.active_skill_name)
            @same_skill_pets = Pet.where("active_skill_name = ? AND number NOT IN (?)", @pet.active_skill_name, @pet.number).all
        end
        
        render :layout => 'application'
    end
    
    def edit
        @pet   = Pet.find_by_id(params[:id])
        if @pet.nil?
            redirect_to root_path
            return
        end
        edit_update_vars
    end
    
    def update
        @pet   = Pet.find_by_id(params[:id])
        if !@pet.update(pet_params)
            edit_update_vars
            render 'edit'
        else
            flash[:notice]  = "pet updated!"
            redirect_to pet_path(@pet.number)
        end
    end#end update
    
    def destroy
        flash[:error]  = "Delete function disabled!"
        @pet   = Pet.find_by_id(params[:id])
        redirect_to pet_path(@pet.number)
        
        return
        
        
        @pet   = Pet.find_by_id(params[:id])
        if @pet.destroy
            flash[:notice]  = "Pet deleted!"
            redirect_to root_path
        else
            edit_update_vars
            render 'edit'
        end
    end
    
    private
    def pet_params
        params.require(:pet).permit(:content, :name, :number, :profile_image, :circle_image, :right_big_image, :skill, :leader_skill, :skill_range, :star, :ranking_hp, :ranking_attack, :ranking_ability, :ranking_leader_skill, :ranking_skill, :ranking_skill_round, :ranking_arrow, :ranking_total, :pet_attribute, :type1, :type2, :chinese_name, :pet_attribute, :before_evolution, :after_evolution, :material_1, :material_2, :material_3, :material_4, :leader_skill_name, :active_skill_name, :obtain)
        
    end
    
    
    
    def new_create_vars
        @submit_label   = "Create"
        @submit_path    = pets_path
        @method         = "post"
    end
    
    def edit_update_vars
        @submit_label   = "Save"
        @submit_path    = pet_path(@pet)
        @method         = "patch"
    end
    
    def get_operating_system
      #if request.user_agent.downcase.match(/iphone/i)
      #  "iPhone"
      #elsif request.user_agent.downcase.match(/android/i)
      #  "Android"
      #elsif request.user_agent.downcase.match(/mac/i)
      #  "Mac"
      #elsif request.user_agent.downcase.match(/windows/i)
      #  "Windows"
      #elsif request.user_agent.downcase.match(/linux/i)
      #  "Linux"
      #elsif request.user_agent.downcase.match(/unix/i)
      #  "Unix"
      #else
      #  "Unknown"
      #end
    end
end
