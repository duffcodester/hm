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

    describe "with valid parent information" do
      let(:parent) { FactoryGirl.create(:parent) }
      before { sign_in parent }

      it { should have_selector('title', text: parent.name) }
      it { should have_link('Parents', href: parents_path) } 
      it { should have_link('Profile', href: parent_path(parent)) }
      it { should have_link('Settings', href: edit_parent_path(parent)) }
      it { should have_link('Sign out', href: signout_path) }

      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should_not have_link('Sign out'), href: signout_path }
      end
    end

    describe "with valid child information" do
      let(:child) { FactoryGirl.create(:child) }
      before { sign_in child }

      it { should have_selector('title', text: child.username) }
      it { should have_link('Children', href: children_path) } 
      it { should have_link('Profile', href: child_path(child)) }
      it { should have_link('Settings', href: edit_child_path(child)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should_not have_link('Sign out'), href: signout_path }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed in parents" do
      let(:parent) { FactoryGirl.create(:parent) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_parent_path(parent)
          fill_in "Email", with: parent.email
          fill_in "Password", with: parent.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit parent')
          end
        end
      end

      describe "in the Parents controller" do

        describe "visiting the edit page" do
          before { visit edit_parent_path(parent) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put parent_path(parent) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the parent index" do
          before { visit parents_path }
          it { should have_selector('title', text: 'Sign in') }
        end
      end

      describe "as wrong parent" do
        let(:parent) { FactoryGirl.create(:parent) }
        let(:wrong_parent) { FactoryGirl.create(:parent, email: "wrong_parent@example.com") }
        before { sign_in parent }

        describe "visiting Parents#edit page" do
          before { visit edit_parent_path(wrong_parent) }
          it { should_not have_selector('title', text: full_title('Edit parent')) }
        end

        describe "submitting a PUT request to the Parents#update action" do
          before { put parent_path(wrong_parent) }
          specify { response.should redirect_to(root_path) }
        end
      end
    end

    describe "for non-signed-in children" do
      let(:child) { FactoryGirl.create(:child) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_child_path(child)
          fill_in "Username", with: child.username
          fill_in "Password", with: child.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit child')
          end
        end
      end

      describe "in the Children controller" do

        describe "visiting the edit page" do
          before { visit edit_child_path(child) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put child_path(child) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the children index" do
          before { visit children_path }
          #Must be admin to view children index
          it { should have_selector('title', text: 'Sign in') }
        end
      end
    end

    describe "as wrong child" do
      let(:child) { FactoryGirl.create(:child) }
      let(:wrong_child) { FactoryGirl.create(:child, username: "wrong_username") }
      before { sign_in child }

      describe "visiting Children#edit page" do
        before { visit edit_child_path(wrong_child) }
        it { should_not have_selector('title', text: full_title('Edit child')) }
      end

      describe "submitting a PUT request to the Parents#update action" do
        before { put child_path(wrong_child) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin parent" do
      let(:parent) { FactoryGirl.create(:parent) }
      let(:non_admin) { FactoryGirl.create(:parent) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Parents#destroy action" do
        before { delete parent_path(non_admin) }
        specify { response.should redirect_to(root_path) }        
      end

      describe "submitting a DELETE request to the Children#destroy action" do
        before { delete child_path(non_admin) }
        specify { response.should redirect_to(root_path) }        
      end
    end
  end
end
