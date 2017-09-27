class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :ip
      t.string :url
      t.timestamps
    end
      add_reference :visitors, :user, index: true
  end
end
