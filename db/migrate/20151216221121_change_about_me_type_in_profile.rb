class ChangeAboutMeTypeInProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :about_me, :text
  end
end
