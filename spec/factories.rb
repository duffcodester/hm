FactoryGirl.define do
  factory :parent do
    sequence(:name)  { |n| "Parent #{n}" }
    sequence(:email) { |n| "parent_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :child do
    sequence(:username) { |n| "Child_#{n}" }
    password "foobar"
    password_confirmation "foobar"
    parent_id 1
  end

  factory :challenge do
    sequence(:name)        { |n| "Challenge #{n}" }
    sequence(:description) { |n| "Challenge Description #{n}" }
    parent_id      1
  end
end