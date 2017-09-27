class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :login
        t.string :password
        t.timestamps
    end
      User.create :login => "admin", :password => "12345678", :name => "HeyHei"
  end
end
