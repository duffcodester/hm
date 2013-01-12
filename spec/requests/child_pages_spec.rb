require 'spec_helper'

describe "Child pages" do
  subject { page }

  describe "index" do
    let(:child) { FactoryGirl.create(:child) }

    before(:each) do
      sign_in child
      visit children_path
    end

    it { should have_title('All children') }
    it { should have_h1('All children') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:child) } }
      after(:all)  { Child.delete_all }

      it { should have_pagination }

      it "should list each children" do
        Child.paginate(page: 1).each do |child|
          page.should have_li(child.username)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin parent" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit children_path
        end

        it { should have_link('delete', href: child_path(Child.first)) }

        it "should be able to delete child" do
          expect { click_link('delete') }.to change(Child, :count).by(-1)
        end

        specify { page.should_not have_link('delete', href: parent_path(admin)) }
      end
    end
  end

  describe "create child page" do
    let(:parent) { FactoryGirl.create(:parent) }

    before do 
      sign_in(parent)
      visit new_child_path 
    end

    it { should have_h1('Sign up a child') }
    it { should have_title(full_title('Child Signup')) }
  end

  describe "child profile page" do
    let(:child) { FactoryGirl.create(:child) }
    before { visit child_path(child) }

    it { should have_h1(child.username) }
    it { should have_title(child.username) }
  end

  describe "signup" do
    let(:parent) { FactoryGirl.create(:parent) }
    before do 
      sign_in(parent)
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
        fill_in "Username",     with: "example_child12"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a child" do
        expect { click_button submit }.to change(Child, :count).by(1)
      end

      describe "after saving the child" do
        before { click_button submit }
        let(:child) { Child.find_by_username('example_child12') }

        it { should have_title(child.username) }
        it { should have_success_message('You') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:child) { FactoryGirl.create(:child) }

    before do
      sign_in child
      visit edit_child_path(child)
    end

    describe "page" do
      it { should have_h1("Update your profile") }
      it { should have_title("Edit child") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_error_message }
    end

    describe "with valid information" do
      let(:new_username)  { "new_name12" }
      before do
        fill_in "Username",         with: new_username
        fill_in "Password",         with: child.password
        fill_in "Confirm Password", with: child.password
        click_button "Save changes"
      end

      it { should have_title(new_username) }
      it { should have_success_message }
      it { should have_link('Sign out', href: signout_path) }
      specify { child.reload.username.should  == new_username }
    end
  end
end
