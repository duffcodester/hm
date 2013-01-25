# == Schema Information
#
# Table name: challenges
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  parent_id   :integer
#  public      :boolean
#  name        :string(255)
#  description :text
#

require 'spec_helper'

describe Challenge do  
  let(:parent) { FactoryGirl.create(:parent) }
  before { @challenge = parent.challenges.build(name: "Example Challenge", description: "This provides a very in depth description of the Example Challenge") }

  subject { @challenge }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  it { should respond_to(:public) }
  its(:parent) { should == parent }

  it { should be_valid }

  #validate_presence(@challenge, :name)

  describe "when challenge name is not present" do
    before { @challenge.name = " " }
    it { should_not be_valid }
  end

  describe "when challenge description is not present" do
    before { @challenge.description = " " } 
    it { should_not be_valid }
  end

  describe "when challenge name is too long" do
    before { @challenge.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "should not validate uniqueness" do
    before do
      Challenge_with_same_name = @challenge.dup
      Challenge_with_same_name.name = @challenge.name.upcase
      Challenge_with_same_name.save
    end

    it { should be_valid }
  end

  describe "challenge name with mixed cased" do
    let(:mixed_case_name) { "eXampLe cHallenGe" }

    it "should be saved as lower cased" do
      @challenge.name = mixed_case_name
      @challenge.save
      @challenge.reload.name.should == mixed_case_name.downcase
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

  describe "that is public"
end
