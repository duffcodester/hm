categories = ["Nutrition", 
              "Exercise", 
              "Academics", 
              "Community Involvement", 
              "The Arts", 
              "Other"]

            # challenges
resources = [["run a mile", "do it fast", true, 1, 2],
             ["eat your broccoli", "all of it", true, 1, 1],
             ["do your homework", "tonight", true, 2, 3],
             ["write a letter to a serviceman", "a nice one", true, 2, 4],
             ["paint a painting", "beautiful", true, 1, 5],
             ["take care of your g'ma", "she's old", true, 2, 6],
            # rewards
             ["eat some pizza", "one piece", true, 1],
             ["candy", "skittles", true, 2],
             ["staying up late", "an hour", true, 1],
             ["playing video games", "COD", true, 1],
             ["playing on the computer", "boss", true, 2],
             ["watch tv", "a few channels", true, 2]]

children = [["my_child", "child3$", 1, "6-8"],
            ["another_child", "child3$", 2, "8-10"],
            ["child", "child3$", 1, "10-12+"]]

parent                       = Parent.find_or_create_by_email("k@m.com")
parent.name                  = "Kelton"
parent.password              = "Kelton3$"
parent.password_confirmation = "Kelton3$"
parent.save

parent                       = Parent.find_or_create_by_email("j@d.com")
parent.name                  = "Josh"
parent.password = parent.password_confirmation = parent.name + "3$"
parent.save

#Category.delete_all
categories.each do |category_name|
  category = Category.find_or_create_by_name(category_name) 
  category.save
end

#Resource.delete_all
resources.each do |resource_info|
  resource_type        = resource_info[4] ? Challenge : Reward
  resource             = resource_type.find_or_create_by_name(resource_info[0])
  resource.description = resource_info[1]
  resource.public      = resource_info[2]
  resource.parent_id   = resource_info[3]
  resource.category_id = resource_info[4] if resource_info[4]
  resource.save
end

children.each do |child_info|
  child           = Child.find_or_create_by_username(child_info[0])
  child.password  = child.password_confirmation = child_info[1]
  child.parent_id = child_info[2]
  child.age_group = child_info[3]
  child.points    = rand(500) + 500
  child.save
end

state_count = 0

50.times do |i|
  challenge = Challenge.offset(rand(Challenge.count)).first
  child     = Child.offset(rand(Child.count)).first
  assigned_challenge = AssignedChallenge.
    find_or_create_by_challenge_id_and_child_id(challenge.id, child.id)
  assigned_challenge.parent_id   = child.parent_id
  assigned_challenge.category_id = challenge.category_id
  assigned_challenge.points      = rand(991) + 9

  case state_count
  when 0
    assigned_challenge.accepted  = false
    assigned_challenge.completed = false
  when 1
    assigned_challenge.accepted  = true
    assigned_challenge.completed = false
  when 2
    assigned_challenge.accepted  = false
    assigned_challenge.completed = true
  end

  assigned_challenge.save

  state_count += 1
  state_count = state_count > 2 ? 0 : state_count
end

30.times do |i|
  reward = Reward.offset(rand(Reward.count)).first
  child  = Child.offset(rand(Child.count)).first
  enabled_reward = EnabledReward.
    find_or_create_by_reward_id_and_child_id(reward.id, child.id)
  enabled_reward.parent_id   = child.parent_id
  enabled_reward.points      = rand(991) + 9

  enabled_reward.save
end
