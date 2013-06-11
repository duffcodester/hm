require 'spec_helper'

describe "Assigning a Challenge" do
  let!(:parent) { FactoryGirl.create(:parent) }
  let!(:challenge) { FactoryGirl.create(:challenge, name: 'test challenge', parent_id: parent.id) }
  let!(:child) { FactoryGirl.create(:child, parent_id: parent.id) }
  let!(:public_challenge) { FactoryGirl.create(:challenge, name: "test public challenge", parent_id: parent.id, public: true) }

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
      it { should have_selector('h4', text: 'Challenge') }
      it { should have_selector('h4', text: 'Select Child')}
      it { should have_selector('h4', text: 'Assign Points (9-999)') }
    end

    describe "should have the right choices" do
      it { has_select?(challenge.name) }
      it { has_select?(child.username) }
      it { has_select?(public_challenge.name) }
    end

    describe "assignment" do
      describe "with invalid information" do
        it "should not assign a challenge" do
          expect { click_button submit }.not_to change(AssignedChallenge, :count)
        end
      end

      describe "with valid information" do
        before do
          select challenge.name, :from => 'assigned_challenge[challenge_id]'
          select child.username, :from => 'assigned_challenge[child_id]'
          fill_in 'assigned_challenge_points', with: '100'
        end
  
        it "should create a challenge" do
          expect { click_button submit }.to change( AssignedChallenge, :count).by(1)
        end   
  
        describe "after assigning the challenge" do
          before { click_button submit }
          let(:assigned_challenge) { AssignedChallenge.find_by_challenge_id(challenge.id) }
  
          it { should have_css('img', src: "Dashboard.png") }
          it { should have_success_message('Challenge Assigned!')}
        end
      end 

      context "from community pool" do
        before { visit "#{new_assigned_challenge_path}?assigned_challenge%5Bchallenge_id%5D=#{challenge.id}" }

        it "should have challenges listed" do
          should have_content(challenge.name)
          should_not have_selector('select', id: 'assigned_challenge_challenge_id')
        end
      end
    end
  end
end

