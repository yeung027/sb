class ChangePrecisionAndScaleWithPetsRankingColumn < ActiveRecord::Migration
  def change
      change_column :pets, :ranking_hp, :decimal, :precision => 4, :scale => 2
      change_column :pets, :ranking_attack, :decimal, :precision => 4, :scale => 2
      change_column :pets, :ranking_ability, :decimal, :precision => 4, :scale => 2
      change_column :pets, :ranking_leader_skill, :decimal, :precision => 4, :scale => 2
      change_column :pets, :ranking_skill, :decimal, :precision => 4, :scale => 2
      change_column :pets, :ranking_skill_round, :decimal, :precision => 4, :scale => 2
      change_column :pets, :ranking_arrow, :decimal, :precision => 4, :scale => 2
      change_column :pets, :ranking_total, :decimal, :precision => 4, :scale => 2
  end
end
