# == Schema Information
#
# Table name: rewards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  public      :boolean
#  parent_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Reward do
  let(:parent) { FactoryGirl.create(:parent) }
  before { @reward = parent.rewards.build(name: "Example Reward", description: "This provides a very in depth description of the Example Reward") }

  subject { @reward }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  it { should respond_to(:public) }
  its(:parent) { should == parent }

  it { should be_valid }

  describe "when reward name is not present" do
    before { @reward.name = " " }
    it { should_not be_valid }
  end

  describe "when reward description is not present" do
    before { @reward.description = " " } 
    it { should_not be_valid }
  end

  describe "when reward name is too long" do
    before { @reward.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "reward name with mixed cased" do
    let(:mixed_case_name) { "eXampLe rEwaRd" }

    it "should be saved as lower cased" do
      @reward.name = mixed_case_name
      @reward.save
      @reward.reload.name.should == mixed_case_name.downcase
    end
  end

  describe "accessible attributes" do
    it "should not allow access to parent_id" do
      expect do
        Reward.new(parent_id: parent.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when parent_id is not present" do
    before { @reward.parent_id = nil }
    it { should_not be_valid }
  end

  describe "that is public"
end
