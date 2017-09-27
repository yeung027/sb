class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
        t.decimal :hp
        t.decimal :attack
        t.decimal :ability
        t.decimal :leader_skill
        t.decimal :skill
        t.decimal :skill_round
        t.decimal :arrow
    end
      add_reference :rankings, :pet, index: true
  end
end
