require 'rails_helper'

RSpec.describe Profile, type: :model do

  it { should belong_to(:user)}
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:blog_title) }
  it { should validate_presence_of(:about_me) }

end
