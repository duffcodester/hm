require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
      before { click_link "Home" }
      it { should_not have_selector('div.alert.alert-error') }
end
    end

    describe "with valid information" do
      let(:parent) { FactoryGirl.create(:parent) }
      before do
        fill_in "Email",    with: parent.email
        fill_in "Password", with: parent.password
        click_button "Sign in"
      end

      it { should have_selector('title', text: parent.name) }
      it { should have_link('Profile', href: parent_path(parent)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end
end
