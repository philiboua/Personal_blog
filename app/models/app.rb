class App < ActiveRecord::Base

  #database schema 

=begin 
create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.string   "screenshot"
    t.text     "content"
    t.string   "website"
    t.string   "repository"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

=end
  
  #database relation
  belongs_to :user 

  #carrierwave uploader 
  mount_uploader :screenshot, ScreenshotUploader

  #database validation 
  validates_presence_of :name, :content, :website
end
