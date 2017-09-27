class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
        t.string :title
        t.text :content
        t.boolean :featured, :default => false
        t.timestamps
    end
    add_reference :posts, :user, index: true
  end
end
