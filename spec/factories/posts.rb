FactoryGirl.define do

  factory :post do
    title "ruby on rails"
    image File.open(File.join(Rails.root, '/spec/fixtures/profile_new_page.jpg'))
    body { Faker::Lorem.sentence }
    slug "ruby on rails"
    user nil
  end

end


