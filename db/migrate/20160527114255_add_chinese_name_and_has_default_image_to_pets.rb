class AddChineseNameAndHasDefaultImageToPets < ActiveRecord::Migration
  def change
      add_column :pets, :chinese_name, :string
      add_column :pets, :has_default_image, :boolean, :default => false
  end
end
