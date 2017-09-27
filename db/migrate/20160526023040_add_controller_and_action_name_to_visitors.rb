class AddControllerAndActionNameToVisitors < ActiveRecord::Migration
  def change
      add_column :visitors, :controller, :string
      add_column :visitors, :action, :string
  end
end
