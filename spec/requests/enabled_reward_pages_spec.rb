require 'spec_helper'

describe "Enabling a Reward" do
  let!(:parent) { FactoryGirl.create(:parent) }
  let!(:reward) { FactoryGirl.create(:reward, name: 'test reward', parent_id: parent.id) }
  let!(:child) { FactoryGirl.create(:child, parent_id: parent.id) }
  let!(:public_reward) { FactoryGirl.create(:reward, name: "test public reward", parent_id: parent.id, public: true) }

  before do
    sign_in(parent)
    visit new_enabled_reward_path
  end

  subject { page }

  describe "enable reward page" do
    let(:submit) { "Enable Reward" }

    describe "should have the right title and page heading" do
      it { should have_title('Enable a Reward') }
      it { should have_selector('h1', text: 'Enable a Reward') }
    end

    describe "should have the right field labels" do
      it { should have_selector('h4', text: 'Select a reward') }
      it { should have_selector('h4', text: 'Select child')}
      it { should have_selector('h4', text: 'Assign Points (9-999)') }
    end

    describe "should have the right choices" do
      it { has_select?(reward.name) }
      it { has_select?(child.username) }
      it { has_select?(public_reward.name) }
    end

    describe "assignment" do
      let(:submit) { "Enable Reward" }

      describe "with invalid information" do
        it "should not assign a challenge" do
          expect { click_button submit }.not_to change(EnabledReward, :count)
        end
      end

      describe "with valid information" do
        before do
          select reward.name, :from => 'enabled_reward[reward_id]'
          select child.username, :from => 'enabled_reward[child_id]'
          fill_in 'enabled_reward_points', with: '100'
        end
  
        it "should create a reward" do
          expect { click_button submit }.to change( EnabledReward, :count).by(1)
        end   
  
        describe "after enabling the reward" do
          before { click_button submit }
          let(:enabled_reward) { EnabledReward.find_by_reward_id(reward.id) }
  
          it { should have_title(reward.name) }
          it { should have_selector('h4', text: reward.name) }
          it { should have_selector('h4', int: enabled_reward.points) }
          it { should have_selector('h4', text: "points.") }
          it { should have_success_message('You')}
        end
      end 
    end
  end
end