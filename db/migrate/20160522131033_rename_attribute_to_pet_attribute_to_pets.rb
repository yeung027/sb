class RenameAttributeToPetAttributeToPets < ActiveRecord::Migration
  def change
      rename_column :pets, :attribute, :pet_attribute
  end
end
