include ApplicationHelper

def valid_signin(parent) # need to get rid of this in rspec tests
  fill_in "Email",    with: parent.email
  fill_in "Password", with: parent.password
  click_button "Sign in"
end

def sign_in(user)
  email_username = user.class == Parent ? user.email : user.username
  visit signin_path
  fill_in "Email or Username", with: email_username
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

#def validate_presence(object, attribute)
 # describe "when #{attribute.to_s} is not present" do
  #  before { object.send(attribute) = " " } # or = nil
   # specify { object.should be_valid }
  #end
#end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_title do |message|
  match { |page| page.should have_selector('title', text: message) }
end

RSpec::Matchers.define :have_h1 do |message|
  match { |page| page.should have_selector('h1', text: message) }
end

RSpec::Matchers.define :have_h3 do |message|
  match { |page| page.should have_selector('h3', text: message) }
end

RSpec::Matchers.define :have_label do |message|
  match { |page| page.should have_selector('label', text: message) }
end

RSpec::Matchers.define :have_li do |message|
  match { |page| page.should have_selector('li', text: message) }
end

RSpec::Matchers.define :have_pagination do
  match { |page| page.should have_selector('div.pagination') }
end
