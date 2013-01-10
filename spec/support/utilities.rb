include ApplicationHelper

def valid_signin(parent)
  fill_in "Email",    with: parent.email
  fill_in "Password", with: parent.password
  click_button "Sign in"
end

def sign_in(parent)
  visit signin_path
  fill_in "Email",    with: parent.email
  fill_in "Password", with: parent.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = parent.remember_token
end

def sign_in(child)
  visit signin_path
  fill_in "Email",    with: child.email
  fill_in "Password", with: child.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = child.remember_token
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

def parent_signin(parent)
  visit signin_path
  fill_in "Email",    with: parent.email
  fill_in "Password", with: parent.password
  click_button "Sign in"
  cookies[:remember_token] = parent.remember_token
end