require 'spec_helper'

describe "Child pages" do

  subject { page }

  describe "create child page" do
    let(:parent) { FactoryGirl.create(:parent) }
    before do 
      sign_in(parent)
      visit new_child_path 
    end

    it { should have_selector('h1',    text: 'Sign up a child') }
    it { should have_selector('title', text: full_title('Child Signup')) }
  end

  describe "child profile page" do
    let(:child) { FactoryGirl.create(:child) }
    before { visit child_path(child) }

    it { should have_selector('h1',    text: child.name) }
    it { should have_selector('title', text: child.name) }
  end

  describe "signup" do
    let(:parent) { FactoryGirl.create(:parent) }
    before do 
      parent_signin(parent)
      visit new_child_path 
    end

    let(:submit) { "Create child account" }

    describe "with invalid information" do
      it "should not create a child" do
        expect { click_button submit }.not_to change(Child, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Child"
        fill_in "Email",        with: "child@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a child" do
        expect { click_button submit }.to change(Child, :count).by(1)
      end

      describe "after saving the child" do
        before { click_button submit }
        let(:child) { Child.find_by_email('child@example.com') }

        it { should have_selector('title', text: child.name) }
        it { should have_selector('div.alert.alert-success', text: 'You' ) }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:child) { FactoryGirl.create(:child) }
    before { visit edit_child_path(child) }

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit child") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end
end
