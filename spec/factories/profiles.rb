

FactoryGirl.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    blog_title { Faker::Lorem.sentence }
    about_me { Faker::Lorem.paragraph }
    photo File.open(File.join(Rails.root, '/spec/fixtures/profile_new_page.jpg'))
    user nil
  end
end
