class AddXmlColumnsToPets < ActiveRecord::Migration
  def change
      add_column :pets, :attribute, :string
      add_column :pets, :type1, :string
      add_column :pets, :type2, :string
      add_column :pets, :abilitys, :string
      add_column :pets, :leader_skill_name, :string
      add_column :pets, :active_skill_name, :string
      add_column :pets, :obtain, :string
      add_column :pets, :before_evolution, :integer
      add_column :pets, :after_evolution, :integer
      add_column :pets, :material_1, :integer
      add_column :pets, :material_2, :integer
      add_column :pets, :material_3, :integer
      add_column :pets, :material_4, :integer
  end
end
