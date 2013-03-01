require 'spec_helper'

describe "Rewards" do

  subject { page }

  describe "reward creation page" do 
    before { visit new_reward_path }

    it { should have_h1('Create a Reward') }
    it { should have_title('Create a Reward') }
    it { should have_label("Name") }
    it { should have_label("Description") }
    it { should have_label("Public?") }
  end

  describe "creation" do
    let(:parent) { FactoryGirl.create(:parent) }
    before do
      sign_in(parent)
      visit new_reward_path
    end

    let(:submit) { "Create Reward" }

    describe "with invalid information" do
      it "should not create a reward" do
        expect { click_button submit }.not_to change(Reward, :count)
      end
    end

    describe "with valid information" do
      before(:each) do
        fill_in "Name",         with: "Example Reward"
        fill_in "Description",  with: "Example Reward Description"
        check "Public?"
      end
      let(:reward) { Reward.find_by_name('example reward') }

      it "should create a reward" do
        expect { click_button submit }.to change(Reward, :count).by(1)
      end

      describe "after saving the reward it redirects to profile" do
        before { click_button submit }
        it { should have_success_message('You')}
        it { should have_h1(reward.parent.name) }
      end

      describe "then the reward page has the reward" do
        before do
          click_button submit
          visit reward_path(reward)
        end

        it { should have_title(reward.name) }
        it { should have_h1(reward.name) }
      end
    end
  end
end

describe "Rewards view" do
  subject { page }

  let(:parent) { FactoryGirl.create(:parent) }
  let(:public_reward) { FactoryGirl.create(:reward, parent_id: parent.id, public: true) }
  let(:private_reward) { FactoryGirl.create(:reward, parent_id: parent.id, public: false) }
  before { public_reward.save }
  before { private_reward.save }

  describe "Rewards Community Pool" do
    before { visit rewards_community_pool_path }

    it { should have_h1('Rewards Community Pool') }
    it { should have_title('Rewards Community Pool') }
    it { should have_content(public_reward.name) }
    it { should_not have_content(private_reward.name) }

    describe "search" do

      describe "for public reward" do
        before do
        fill_in "search", with: public_reward.name
        click_button 'Search'
        end
  
        it { should have_content(public_reward.name) }
      end

      describe "for private reward" do
        before do
          fill_in "search", with: private_reward.name
          click_button 'Search'
        end

        it { should_not have_content(private_reward.name) }
      end
    end
  end

  describe "Your" do
    before { sign_in parent }
    before { visit rewards_your_path }

    it { should have_title('Your') }
    it { should have_h1('Your rewards') }
    it { should have_content(private_reward.name) }
    it { should have_content(public_reward.name) }
  end
end
