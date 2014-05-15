class FixWikisTable < ActiveRecord::Migration
  def change
    change_column :wikis, :public, :boolean, default: true, null: false
  end
end
