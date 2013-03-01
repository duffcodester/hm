namespace :db do
  desc "Fill database with sample parents and children"
  task populate: :environment do
    admin = Parent.create!(name: "Admin User",
                         email: "admin@railstutorial.org",
                         password: "foobar1!",
                         password_confirmation: "foobar1!")
    admin.toggle!(:admin)

    Parent.create!(name: "Example Parent",
                 email: "example_parent@railstutorial.org",
                 password: "foobar1!",
                 password_confirmation: "foobar1!")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-parent-#{n+1}@railstutorial.org"
      password  = "password1!"
      Parent.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    Child.create!(username: "UserName",
                 password: "foobar1!",
                 password_confirmation: "foobar1!",
                 parent_id: "1")
    99.times do |n|
      username  = "UserName_#{n+1}"
      password  = "password1!"
      parent_id = "1"
      Child.create!(username: username,
                   password: password,
                   password_confirmation: password,
                   parent_id: parent_id)
    end
  end
end