require 'spec_helper'

describe "Parent pages" do

  subject { page }

  describe "index" do

    let(:parent) { FactoryGirl.create(:parent) }

    before(:each) do
      sign_in parent
      visit parents_path
    end

    it { should have_selector('title', text: 'All parents') }
    it { should have_selector('h1',    text: 'All parents') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:parent) } }
      after(:all)  { Parent.delete_all }

      it { should have_pagination }

      it "should list each parent" do
        Parent.paginate(page: 1).each do |parent|
          page.should have_selector('li', text: parent.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin parent" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit parents_path
        end

        it { should have_link('delete', href: parent_path(Parent.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(Parent, :count).by(-1)
        end
        
        it "should not be able to delete himself" do
          page.should_not have_link('delete', href: parent_path(admin))
        end
      end
    end
  end
  
  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile page" do
    let(:parent) { FactoryGirl.create(:parent) }

    let(:challenge) { FactoryGirl.create(:challenge) }
    let(:reward) { FactoryGirl.create(:reward) }
    let!(:assigned_challenge) { FactoryGirl.create(:assigned_challenge, parent_id: parent.id, challenge_id: challenge.id) }
    let!(:accepted_challenge) { FactoryGirl.create(:assigned_challenge, parent_id: parent.id, challenge_id: challenge.id, accepted: true) }
    let!(:rejected_challenge) { FactoryGirl.create(:assigned_challenge, parent_id: parent.id, challenge_id: challenge.id, rejected: true) }
    let!(:completed_challenge) { FactoryGirl.create(:assigned_challenge, parent_id: parent.id, challenge_id: challenge.id, completed: true) }
    let!(:enabled_reward) { FactoryGirl.create(:enabled_reward, parent_id: parent.id, reward_id: reward.id) }

    before { visit parent_path(parent) }

    it { should have_selector('h1',    text: parent.name) }
    it { should have_selector('title', text: parent.name) }

    describe "should display assigned challenges" do
      it { should have_selector('h4', text: "Assigned Challenges") }
      
      it { should have_li(assigned_challenge.challenge.name) }
    end

    describe "should display accepted challenges" do
      it { should have_selector('h4', text: "Accepted Challenges") }
      it { should have_li(accepted_challenge.challenge.name) }
    end

    describe "should display completed challenges" do
      it { should have_selector('h4', text: "Completed Challenges") }
      it { should have_li(completed_challenge.challenge.name) }

      describe "with validate link" do
          it { should have_button("Validate") }
        end
    end

    describe "should display rejected challenges" do
      it { should have_selector('h4', text: "Rejected Challenges") }
      it { should have_li(rejected_challenge.challenge.name) }
    end

    describe "should display enabled rewards" do
      it { should have_selector('h4', text: "Enabled Rewards") }
      it { should have_li(enabled_reward.reward.name) }
    end
  end

  describe "assigned challenge actions" do
    let(:parent) { FactoryGirl.create(:parent) }
    let(:child) { FactoryGirl.create(:child, parent_id: parent.id, points: 100) }
    let(:challenge) { FactoryGirl.create(:challenge) }
    let!(:assigned_challenge) { FactoryGirl.create(:assigned_challenge, parent_id: parent.id, child_id: child.id, challenge_id: challenge.id, completed: true) }
    let!(:orig_points) { child.points }

    before(:each) do
      sign_in parent
      visit parent_path(parent)
    end

    describe "validating challenge" do
      before do
        click_button "Validate" 
        assigned_challenge.reload
        child.reload
      end

      subject { assigned_challenge }

      it { should be_validated }
      it { should_not be_completed }
      it { should_not be_rejected }
      it { should_not be_accepted }

      specify { page.should have_success_message('Validated') }

      it "should redirect to parent page" do
        page.should have_h1(parent.name)
      end

      it "should assign the correct points to child" do
        child.points.should eq(orig_points + assigned_challenge.points)
      end
    end
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

      describe "after saving the parent" do
        before { click_button submit }
        let(:parent) { Parent.find_by_email('parent@example.com') }

        it { should have_selector('title', text: parent.name) }
        it { should have_success_message('Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:parent) { FactoryGirl.create(:parent) }
    before do
      sign_in parent
      visit edit_parent_path(parent)
    end

    describe "page" do
      it { should have_selector('h1', text: 'Update your profile') }
      it { should have_selector('title', text: 'Edit parent') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: parent.password
        fill_in "Confirm Password", with: parent.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_success_message }
      it { should have_link('Sign out', href: signout_path) }
      specify { parent.reload.name.should  == new_name }
      specify { parent.reload.email.should == new_email }
    end
  end
end
