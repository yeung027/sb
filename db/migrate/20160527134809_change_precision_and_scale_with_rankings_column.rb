class ChangePrecisionAndScaleWithRankingsColumn < ActiveRecord::Migration
  def change
      change_column :rankings, :hp, :decimal, :precision => 4, :scale => 2
      change_column :rankings, :attack, :decimal, :precision => 4, :scale => 2
      change_column :rankings, :ability, :decimal, :precision => 4, :scale => 2
      change_column :rankings, :leader_skill, :decimal, :precision => 4, :scale => 2
      change_column :rankings, :skill, :decimal, :precision => 4, :scale => 2
      change_column :rankings, :skill_round, :decimal, :precision => 4, :scale => 2
      change_column :rankings, :arrow, :decimal, :precision => 4, :scale => 2
  end
end
