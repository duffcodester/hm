FactoryGirl.define do
  factory :parent do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :child do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
    parent_id 1
  end

  factory :challenge do
    challenge_name "Example Challenge"
    point_value    100
    parent_id      1
  end
end