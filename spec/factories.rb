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
    points 0
  end

  factory :challenge do
    sequence(:name)        { |n| "Challenge #{n}" }
    sequence(:description) { |n| "Challenge Description #{n}" }
    parent_id 1
    public false
  end

  factory :reward do
    sequence(:name)        { |n| "Reward #{n}" }
    sequence(:description) { |n| "Reward Description #{n}" }
    parent_id 1
    public false
  end

  factory :assigned_challenge do
    points       100
    accepted     false
    parent_id    1
    child_id     1
    challenge_id 1
  end

  factory :enabled_reward do
    points       100
    redeemed     false
    parent_id    1
    child_id     1
    reward_id    1
  end
end