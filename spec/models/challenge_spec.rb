require 'spec_helper'

describe Challenge do  
  let(:parent) { FactoryGirl.create(:parent) }
  before { @challenge = parent.challenges.build(challenge_name: "Example Challenge", point_value: "10") }

  subject { @challenge }

  it { should respond_to(:challenge_name) }
  it { should respond_to(:point_value) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  its(:parent) { should == parent }

  it { should be_valid }

  describe "when challenge name is not present" do
    before { @challenge.challenge_name = " " }
    it { should_not be_valid }
  end

  describe "when point value is not present" do
    before { @challenge.point_value = nil } 
    it { should_not be_valid }
  end

  describe "when challenge name is too long" do
    before { @challenge.challenge_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "point value is an int" do
    it { @challenge.point_value.should be_an_instance_of(Fixnum) }
  end

  describe "when point value is too small" do
    before { @challenge.point_value = 0 }
    it { should_not be_valid }
  end

  describe "when point value is too big" do
    before { @challenge.point_value = 1000 }
    it { should_not be_valid }
  end

  # tests to check for enforcing of challenge name uniqueness
  describe "when challenge name already exists" do
    before do
      #let(:parent) { FactoryGirl.create(:parent) }
      #visit signin_path 
      #valid_signin(parent)
      #visit new_challenge_path
      Challenge_with_same_name = @challenge.dup
      Challenge_with_same_name.challenge_name = @challenge.challenge_name.upcase
      Challenge_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "challenge name with mixed cased" do
    let(:mixed_case_challenge_name) { "eXampLe cHallenGe" }

    it "should be saved as all lower-case" do
      @challenge.challenge_name = mixed_case_challenge_name
      @challenge.save
      @challenge.reload.challenge_name.should == mixed_case_challenge_name.downcase
    end
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Challenge.new(parent_id: parent.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when parent_id is not present" do
    before { @challenge.parent_id = nil }
    it { should_not be_valid }
  end
end