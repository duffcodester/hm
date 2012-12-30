require 'spec_helper'

describe "Challenge Creation" do

  subject { page }

  describe "challenge creation page" do 
    before { visit create_challenge_path }

    it { should have_selector('h1', text: 'Create a Challenge') }
    it { should have_selector('title', text: 'Create a Challenge') }
  end

  describe "creation" do
    before { visit create_challenge_path }

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
        let(:challenge) { Challenge.find_by_challenge_name('Example Challenge') }

        it { should have_selector('title', text: challenge.challenge_name) }
      end
    end

    describe "challenges link appears on signin" do
      #before { valid_signin }
    end
  end
end