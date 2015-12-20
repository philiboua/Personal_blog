class Post < ActiveRecord::Base
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title, :body
end
