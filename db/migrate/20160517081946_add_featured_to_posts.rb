class AddFeaturedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :featured, :string
  end
end
