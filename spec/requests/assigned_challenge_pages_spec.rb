require 'spec_helper'

describe "Assigning a Challenge" do
  let(:parent) { FactoryGirl.create(:parent) }
  let(:challenge) { FactoryGirl.create(:challenge, name: 'test challenge', parent_id: parent.id) }
  let(:child) { FactoryGirl.create(:child, parent_id: parent.id) }

  before do
    sign_in(parent)
    visit new_assigned_challenge_path
  end

  subject { page }

  describe "assign challenge page" do
    let(:submit) { "Assign Challenge" }

    describe "should have the right title and page heading" do
      it { should have_title('Assign a Challenge') }
      it { should have_selector('h1', text: 'Assign a Challenge') }
    end

    describe "should have the right field labels" do
      it { should have_selector('h4', text: 'Select a challenge') }
      it { should have_selector('h4', text: 'Select children')}
      it { should have_selector('h4', text: 'Assign Points (9-999)') }
    end

    describe "should have the right choices" do
      it { has_field?(challenge.name) }
      #it { should have_label(challenge.name)  }
      it { has_field?(child.username) }
      #it { should have_label(child.username)  }
    end

    describe "assignment" do

      describe "with invalid information" do
        it "should not assign a challenge" do
          expect { click_button submit }.not_to change(AssignedChallenge, :count)
        end
      end

      describe "with valid information" do
        before do
          #choose challenge.name
          #choose child.username
          fill_in 'assigned_challenge_points', with: '100'
        end
  
        it "should create a challenge" do
          expect { click_button submit }.to change( AssignedChallenge, :count).by(1)
        end   
  
        describe "after assigning the challenge" do
          before { click_button submit }
          let(:challenge) { Challenge.find_by_name('test challenge') }
  
          it { should have_title(challenge.name) }
          it { should have_h1(challenge.name) }
          it { should have_success_message('You')}
        end
      end 
    end
  end
end