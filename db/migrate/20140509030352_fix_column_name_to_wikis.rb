class FixColumnNameToWikis < ActiveRecord::Migration
  def change
    rename_column :wikis, :pulic, :public 
  end
end
