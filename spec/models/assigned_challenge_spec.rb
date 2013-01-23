require 'spec_helper'

describe AssignedChallenge do
  let(:parent)    { FactoryGirl.create(:parent) }
  let(:child)     { FactoryGirl.create(:child, parent_id: parent.id) }
  let(:challenge) { FactoryGirl.create(:challenge, parent_id: parent.id) }
  before { @assigned_challenge = parent.assigned_challenges.build(child_id: child.id, challenge_id: challenge.id, points: 100) }

  subject { @assigned_challenge }

  it { should respond_to(:points) }
  it { should respond_to(:accepted) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  it { should respond_to(:child_id) }
  it { should respond_to(:child) }
  it { should respond_to(:challenge_id) }
  it { should respond_to(:challenge) }
  its(:parent)    { should == parent }
  its(:child)     { should == child }
  its(:challenge) { should == challenge }

  it { should be_valid }
  it { should_not be_accepted }

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
end
