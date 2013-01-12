require 'spec_helper'

describe "Challenge Creation" do

  subject { page }

  describe "challenge creation page" do 
    before { visit new_challenge_path }

    it { should have_selector('h1', text: 'Create a Challenge') }
    it { should have_selector('title', text: 'Create a Challenge') }
    it { should have_selector('label', text: "Description") }
    it { should have_selector('label', text: "Point Value (9-999)") }
    it { should have_selector('label', text: "Public?") }

  end

  describe "creation" do
    let(:parent) { FactoryGirl.create(:parent) }
    before do
      visit signin_path 
      valid_signin(parent)
      visit new_challenge_path
    end

    let(:submit) { "Create Challenge" }

    describe "with invalid information" do
      it "should not create a challenge" do
        expect { click_button submit }.not_to change(Challenge, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Description",         with: "Example Challenge"
        fill_in "Point Value (9-999)", with: "100"
      end

      it "should create a challenge" do
        expect { click_button submit }.to change(Challenge, :count).by(1)
      end

      describe "after saving the challenge" do
        before { click_button submit }
        let(:challenge) { Challenge.find_by_challenge_name('example challenge') }

        it { should have_selector('title', text: challenge.challenge_name.capitalize) }
        it { should have_selector('h1', text: challenge.challenge_name.capitalize) }
        it { should have_selector('div.alert.alert-success', text: 'You')}
      end
    end
  end
end

describe "Challenges view" do
  subject { page }

  # refactor out parent info and add sequence to differentiate challenge names
  let(:parent) { FactoryGirl.create(:parent) }
  let(:public_challenge) { FactoryGirl.create(:challenge, challenge_name: "Public Challenge", parent_id: parent.id, public: true) }
  let(:private_challenge) { FactoryGirl.create(:challenge, challenge_name: "Private Challenge", parent_id: parent.id, public: false) }
  before { public_challenge.save }
  before { private_challenge.save }

  describe "Community Pool" do
    before { visit community_pool_path }

    it { should have_selector('h1', text: 'Community Pool') }
    it { should have_selector('title', text: 'Community Pool') }
    it { should have_content(public_challenge.challenge_name) }
    it { should_not have_content(private_challenge.challenge_name) }
  end

  describe "Your" do
    before { sign_in parent }
    before { visit challenges_your_path }

    it { should have_selector('title',text: 'Your') }
    it { should have_selector('h1',text: 'Your challenges') }
    it { should have_content(private_challenge.challenge_name) }
    it { should have_content(public_challenge.challenge_name) }
  end
end
