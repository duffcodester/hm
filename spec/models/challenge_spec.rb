# == Schema Information
#
# Table name: resources
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  public      :boolean
#  parent_id   :integer
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

require 'spec_helper'

describe Challenge do  
  let(:parent) { FactoryGirl.create(:parent) }
  let(:category) { FactoryGirl.create(:category) }
  before { @challenge = parent.challenges.build(name: "Example Challenge", description: "This provides a very in depth description of the Example Challenge") }

  subject { @challenge }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  it { should respond_to(:public) }
  it { should respond_to(:assigned_challenges) }
  it { should respond_to(:categories) }
  it { should_not respond_to(:category) }
  it { should_not respond_to(:category_id) }
  its(:parent) { should == parent }
  its(:categories) { should == [] }

  it { should be_valid }
  it { should_not be_public }

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

  #describe "when there are no categories" do
  #  before { @challenge.categories = [] }
  #  it { should_not be_valid }
  #end

  context "when using categories" do
    let(:categories) { %w{Nutrition Exercise Academics} }
    before do
      categories.each do |category|
        @challenge.categories << Category.new(name: category)
      end
      @challenge.save
      @challenge.reload
    end

    it "should have and belong to many categories" do
      @challenge.categories.map{|c| c.name}.should eq(categories)
    end
  end
end
