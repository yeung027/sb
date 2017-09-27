class AddIpToRankings < ActiveRecord::Migration
  def change
      add_column :rankings, :ip, :string
  end
end
