class RemoveFeaturedFromPosts < ActiveRecord::Migration
  def change
      remove_column :posts, :featured
  end
end
