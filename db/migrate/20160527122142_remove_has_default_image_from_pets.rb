class RemoveHasDefaultImageFromPets < ActiveRecord::Migration
  def change
      remove_column :pets, :has_default_image
  end
end
