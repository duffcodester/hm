namespace :db do
  desc "Fill database with sample parents and children"
  task populate: :environment do
    admin = Parent.create!(name: "Admin User",
                         email: "admin@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)

    Parent.create!(name: "Example Parent",
                 email: "example_parent@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-parent-#{n+1}@railstutorial.org"
      password  = "password"
      Parent.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    Child.create!(username: "UserName",
                 password: "foobar",
                 password_confirmation: "foobar",
                 parent_id: "1")
    99.times do |n|
      username  = "UserName_#{n+1}"
      password  = "password"
      parent_id = "1"
      Child.create!(username: username,
                   password: password,
                   password_confirmation: password,
                   parent_id: parent_id)
    end
  end
end