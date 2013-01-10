FactoryGirl.define do
  factory :parent do
    sequence(:name)  { |n| "Parent #{n}" }
    sequence(:email) { |n| "parent_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :child do
    sequence(:name)  { |n| "Child #{n}" }
    sequence(:email) { |n| "child_#{n}@example.com"}   
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