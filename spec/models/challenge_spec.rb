# == Schema Information
#
# Table name: challenges
#
#  id             :integer          not null, primary key
#  challenge_name :string(255)
#  point_value    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parent_id      :integer
#  public         :boolean
#

require 'spec_helper'

describe Challenge do  
  let(:parent) { FactoryGirl.create(:parent) }
  before { @challenge = parent.challenges.build(challenge_name: "Example Challenge", point_value: "10") }

  subject { @challenge }

  it { should respond_to(:challenge_name) }
  it { should respond_to(:point_value) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  it { should respond_to(:public) }
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

  describe "should not validate uniqueness" do
    before do
      Challenge_with_same_name = @challenge.dup
      Challenge_with_same_name.challenge_name = @challenge.challenge_name.upcase
      Challenge_with_same_name.save
    end

    it { should be_valid }
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
    it "should not allow access to parent_id" do
      expect do
        Challenge.new(parent_id: parent.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when parent_id is not present" do
    before { @challenge.parent_id = nil }
    it { should_not be_valid }
  end

  describe "that is public" do
  end
end
