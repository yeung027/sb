class RankingsController < ApplicationController
    layout "backend"
    before_action :authenticate_user, except: [:visitor_create]
    include ActionView::Helpers::NumberHelper
    
    def update_all_pets_rankings
       # pet    = Pet.find_by_id(1387)
        #average_hp   = Ranking.where("pet_id = ?", 1387).average(:hp)
        
        #render :plain => average_hp.nil?
        #pet.calculate_ranking
        
        #return
        
        pets    = Pet.all
        
        pets.each do |pet|
            pet.calculate_ranking
        end
        flash[:notice]  = "Finish"
        redirect_to root_path
    end
    
    def visitor_create
        
        
        #render :plain => ranking_params
        #return
        
        @count      = Ranking.where("pet_id = ? AND ip = ?", params[:pet_id], request.remote_ip).count
        @ranking    = Ranking.new(ranking_params)
        @ranking.pet_id = params[:pet_id]
        @ranking.ip = request.remote_ip
        @pet        = Pet.find_by_id(params[:pet_id])
        
        if @count > 0
            flash[:error]  = "你已評價過此棋寵"
            redirect_to pet_path(@pet.number)
            return
        elsif @pet.nil?
            redirect_to root_path
            return
        elsif @ranking.save! && @pet.calculate_ranking
            flash[:notice]  = "多謝您的意見!"
            redirect_to pet_path(@pet.number)
            return
        else
            flash[:error]  = "發生錯誤! 請稍後再重試."
            redirect_to pet_path(@pet.number)
            return
        end
        
        
    end
    
    private
    def ranking_params
        params.require(:ranking).permit(:hp, :attack, :ability, :leader_skill, :skill, :skill_round, :arrow, :pet_id)
    end
    
    
end
