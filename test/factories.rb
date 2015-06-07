FactoryGirl.define do
  
  factory :user do
    email "akiko@akiko.com"
    password "123456789sjklf;nkls;"
  end

  factory :place do
    name "dominos"
    description "it's really good"
    address "997 Apple St"
    association :user
  end

  factory :comment do
    message "blah blah blah"
    rating "4_stars"
    association :user
    association :place
  end
end