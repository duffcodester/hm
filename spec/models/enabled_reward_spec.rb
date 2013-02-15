# == Schema Information
#
# Table name: enabled_rewards
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  reward_id  :integer
#  points     :integer
#  redeemed   :boolean          default(FALSE)
#  child_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe EnabledReward do
  let(:parent)    { FactoryGirl.create(:parent) }
  let(:child)     { FactoryGirl.create(:child, parent_id: parent.id) }
  let(:reward) { FactoryGirl.create(:reward, parent_id: parent.id) }
  before { @enabled_reward = parent.enabled_rewards.build(child_id: child.id, reward_id: reward.id, points: 100) }

  subject { @enabled_reward }

  it { should respond_to(:points) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  it { should respond_to(:child_id) }
  it { should respond_to(:child) }
  it { should respond_to(:reward_id) }
  it { should respond_to(:reward) }
  its(:parent)    { should == parent }
  its(:child)     { should == child }
  its(:reward) { should == reward }

  it { should be_valid }
  it { should_not be_redeemed }

  describe "enabled_reward points is an int/fixnum" do
    before { @enabled_reward.points = '10' }
    its(:points) { should be_an_instance_of(Fixnum) }
  end

  describe "when enabled_reward points are not present" do
    before { @enabled_reward.points = nil }
    it { should_not be_valid }
  end

  # range: 9-999
  describe "when enabled_reward points are not in range" do
    before { @enabled_reward.points = 8 }
    it { should_not be_valid }
    before { @enabled_reward.points = 1000 }
    it { should_not be_valid }
  end

  describe "when parent_id is not present" do
    before { @enabled_reward.parent_id = nil } 
    it { should_not be_valid }
  end

  describe "when child_id is not present" do
    before { @enabled_reward.child_id = nil } 
    it { should_not be_valid }
  end
  
  describe "when reward_id is not present" do
    before { @enabled_reward.reward_id = nil } 
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to parent_id" do
      expect do
        EnabledReward.new(parent_id: parent.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to child_id" do
      expect do
        EnabledReward.new(child_id: child.id)
      end.not_to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to reward_id" do
      expect do
        EnabledReward.new(reward_id: reward.id)
      end.not_to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "EnabledReward factory" do
    it "should make a valid EnabledReward" do
      FactoryGirl.build(:enabled_reward).should be_valid
    end
  end
end
