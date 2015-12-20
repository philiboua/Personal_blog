class Profile < ActiveRecord::Base

  #database schema 
=begin 
  create_table :profiles do |t|
    t.string :first_name
    t.string :last_name
    t.string :blog_title
    t.string :image
    t.string :about_me
    t.references :user, index: true, foreign_key: true

    t.timestamps null: false
    end
=end 

  #relational database 
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  #validation 
  validates_presence_of :first_name, :last_name, :blog_title, :about_me

end
