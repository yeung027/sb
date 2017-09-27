class AddDefaultValueToPetsRanking < ActiveRecord::Migration
  def change
      change_column :pets, :star, :integer, :default => 0
      change_column :pets, :ranking_hp, :decimal, :default => 0
      change_column :pets, :ranking_attack, :decimal, :default => 0
      change_column :pets, :ranking_ability, :decimal, :default => 0
      change_column :pets, :ranking_leader_skill, :decimal, :default => 0
      change_column :pets, :ranking_skill, :decimal, :default => 0
      change_column :pets, :ranking_skill_round, :decimal, :default => 0
      change_column :pets, :ranking_arrow, :decimal, :default => 0
      change_column :pets, :ranking_total, :decimal, :default => 0
  end
end
