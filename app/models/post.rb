class Post < ActiveRecord::Base

  #database schema 

=begin 
  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end
=end

  #database relations 
  belongs_to :user

  #database validation 
  validates_presence_of :title, :body

  #friendly_id_url 
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  
  #carrierwave uplodader
  mount_uploader :image, ImageUploader

end
