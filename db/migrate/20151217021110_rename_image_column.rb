class RenameImageColumn < ActiveRecord::Migration
  def change
    rename_column :profiles, :image_id, :photo
  end
end
