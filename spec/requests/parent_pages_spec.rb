require 'spec_helper'

describe "Parent pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile page" do
    let(:parent) { FactoryGirl.create(:parent) }
    before { visit parent_path(parent) }

    it { should have_selector('h1',    text: parent.name) }
    it { should have_selector('title', text: parent.name) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a parent" do
        expect { click_button submit }.not_to change(Parent, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Parent"
        fill_in "Email",        with: "parent@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a parent" do
        expect { click_button submit }.to change(Parent, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:parent) { Parent.find_by_email('parent@example.com') }

        it { should have_selector('title', text: parent.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome' ) }
        it { should have_link('Sign out') }
      end
    end
  end
end
