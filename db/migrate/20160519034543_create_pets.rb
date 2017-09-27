class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.integer :number
      t.string :name
      t.text :content
      t.attachment :profile_image
      t.attachment :circle_image
      t.attachment :right_big_image
      t.text :skill
      t.text :leader_skill
      t.string :skill_range
      t.timestamps
    end
  end
end
