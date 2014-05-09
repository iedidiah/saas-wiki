class AddPublicToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :pulic, :boolean
  end
end
