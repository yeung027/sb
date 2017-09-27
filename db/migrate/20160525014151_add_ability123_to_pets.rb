class AddAbility123ToPets < ActiveRecord::Migration
  def change
      remove_column :pets, :abilitys
      add_column :pets, :ability1, :string
      add_column :pets, :ability2, :string
      add_column :pets, :ability3, :string
  end
end
