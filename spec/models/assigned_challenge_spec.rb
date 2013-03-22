# == Schema Information
#
# Table name: assigned_challenges
#
#  id           :integer          not null, primary key
#  parent_id    :integer
#  challenge_id :integer
#  points       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  child_id     :integer
#  accepted     :boolean          default(FALSE)
#  rejected     :boolean          default(FALSE)
#  completed    :boolean          default(FALSE)
#  validated    :boolean          default(FALSE)
#

require 'spec_helper'

describe AssignedChallenge do
  let(:parent)    { FactoryGirl.create(:parent) }
  let(:child)     { FactoryGirl.create(:child, parent_id: parent.id) }
  let(:challenge) { FactoryGirl.create(:challenge, parent_id: parent.id) }
  let(:category)  { FactoryGirl.create(:category) }

  before { @assigned_challenge = parent.assigned_challenges.build(child_id: child.id, challenge_id: challenge.id, category_id: category.id, points: 100) }

  subject { @assigned_challenge }

  it { should respond_to(:points) }
  it { should respond_to(:accepted) }
  it { should respond_to(:completed) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  it { should respond_to(:child_id) }
  it { should respond_to(:child) }
  it { should respond_to(:challenge_id) }
  it { should respond_to(:challenge) }
  it { should respond_to(:category_id) }
  it { should respond_to(:category) }
  its(:parent)    { should == parent }
  its(:child)     { should == child }
  its(:challenge) { should == challenge }
  its(:category)  { should == category }

  it { should be_valid }
  it { should_not be_accepted }
  it { should_not be_completed }

  describe "assigned_challenge points is an int/fixnum" do
    before { @assigned_challenge.points = '10' }
    its(:points) { should be_an_instance_of(Fixnum) }
  end

  describe "when assigned_challenge points are not present" do
    before { @assigned_challenge.points = nil }
    it { should_not be_valid }
  end

  # range: 9-999
  describe "when assigned_challenge points are not in range" do
    before { @assigned_challenge.points = 8 }
    it { should_not be_valid }
    before { @assigned_challenge.points = 1000 }
    it { should_not be_valid }
  end

  describe "when parent_id is not present" do
    before { @assigned_challenge.parent_id = nil } 
    it { should_not be_valid }
  end

  describe "when child_id is not present" do
    before { @assigned_challenge.child_id = nil } 
    it { should_not be_valid }
  end
  
  describe "when challenge_id is not present" do
    before { @assigned_challenge.challenge_id = nil } 
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to parent_id" do
      expect do
        AssignedChallenge.new(parent_id: parent.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to child_id" do
      expect do
        AssignedChallenge.new(child_id: child.id)
      end.not_to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to challenge_id" do
      expect do
        AssignedChallenge.new(challenge_id: challenge.id)
      end.not_to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "AssignedChallenge factory" do
    it "should make a valid AssignedChallenge" do
      FactoryGirl.build(:assigned_challenge).should be_valid
    end
  end

  context "when category_id is not present" do
    before { @assigned_challenge.category_id = nil }
    it { should_not be_valid }
  end
end
