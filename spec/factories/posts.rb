FactoryGirl.define do

  factory :post do
    title { Faker::Lorem.sentence }
    image File.open(File.join(Rails.root, '/spec/fixtures/profile_new_page.jpg'))
    body { Faker::Lorem.sentence }
    user nil
  end

end


