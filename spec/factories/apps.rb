FactoryGirl.define do
  factory :app do
    name { Faker::Name.title }
    screenshot File.open(File.join(Rails.root, '/spec/fixtures/profile_new_page.jpg'))
    content { Faker::Lorem.paragraph }
    website { Faker::Internet.url }
    repository { Faker::Internet.url }
    user nil
  end

end
