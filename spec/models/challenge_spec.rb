require 'spec_helper'

describe Challenge do  
  before { @challenge = Challenge.new(challenge_name: "Example Challenge",
                                      point_value: "10") }

  subject { @challenge }

  it { should respond_to(:challenge_name) }
  it { should respond_to(:point_value) }

  it { should be_valid }

  describe "when challenge name is not present" do
    before { @challenge.challenge_name = " " }
    it { should_not be_valid }
  end

  # remove these tests when do value is int
  describe "when point value is not present" do
    before { @challenge.point_value = " " } 
    it { should_not be_valid }
  end

  describe "when point value is too long" do
    before { @challenge.point_value = "a" * 1000 } 
    it { should_not be_valid }
  end
  # end remove

  describe "when challenge name is too long" do
    before { @challenge.challenge_name = "a" * 51 }
    it { should_not be_valid }
  end

  # tests for challenge model once db has been migrated to int
  describe "point value is an int" do
#    it { @challenge.point_value.should be_an_instance_of(Int) }
#    it { @challenge.point_value.should be_an_instance_of(Fixnum) } # really is a fixnum
  end

  describe "when point value is not present" do
#    before { @challenge.point_value = nil} # replace other test when db change
#    it { should_not be_valid }
  end

  describe "when point value is too small" do
#    before { @challenge.point_value = 8 }
#    it { should_not be_valid }
  end

  describe "when point value is too big" do
#    before { @challenge.point_value = 1000 }
#    it { should_not be_valid }
  end

  # tests to check for enforcing of challenge name uniqueness
  describe "when challenge name already exists" do
#    before do
#      Challenge_with_same_name = @challenge.dup
#      Challenge_with_same_name.challenge_name = @challenge.challenge_name.upcase
#      Challenge_with_same_name.save
#    end
#
#    it { should_not be_valid }
  end

  describe "challenge name with mixed cased" do
#    let(:mixed_case_challenge_name) { "eXampLe cHallenGe" }
#
#    it "should be saved as all lower-case" do
#      @challenge.challenge_name = mixed_case_challenge_name
#      @challenge.save
#      @challenge.reload.challenge_name.should == mixed_case_challenge_name.downcase
#    end
  end
end