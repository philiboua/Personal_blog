class FixImageColumn < ActiveRecord::Migration
  def change
    rename_column :profiles, :image, :image_id
  end
end
