class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :blog_title
      t.string :image
      t.string :about_me
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
