# == Schema Information
#
# Table name: children
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  parent_id       :integer
#  username        :string(255)
#  points          :integer
#

require 'spec_helper'

describe Child do
  let(:parent) { FactoryGirl.create(:parent) }
  before{ @child = parent.children.build(
                             username: "Example_child",
                             password:              "foobar",
                             password_confirmation: "foobar") }

  subject { @child }

  it { should_not respond_to(:name) }
  it { should_not respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:assigned_challenges) }
  it { should respond_to(:points) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  its(:parent) { should == parent } 
  its(:points) { should == 0 }

  it { should be_valid }

  describe "when username is not present" do
    before { @child.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too short" do
    before { @child.username = "a" * 2 }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @child.username = "a" * 17 }
    it { should_not be_valid }
  end

  describe "when username format is invalid" do
    it "should be invalid" do
      usernames = %w[child%foo example-child child@example.com]
      usernames.each do |invalid_username|
        @child.username = invalid_username
        @child.should_not be_valid
      end      
    end
  end

  describe "when username format is valid" do
    it "should be valid" do
      #only accept usernames with letters, underscores, and numbers
      usernames = %w[Example_child child_92 ex_am_ple]
      usernames.each do |valid_username|
        @child.username = valid_username
        @child.should be_valid
      end      
    end
  end

  describe "when username address is already taken" do
    before do
      Child_with_same_username = @child.dup
      Child_with_same_username.username = @child.username.upcase
      Child_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "username address with mixed case" do
    let(:mixed_case_username) { "UsErNaMe" }

    it "should be saved as all lower-case" do
      @child.username = mixed_case_username
      @child.save
      @child.reload.username.should == mixed_case_username.downcase
    end
  end

  describe "when password is not present" do
    before { @child.password = @child.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @child.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
      before { @child.password_confirmation = nil }
      it { should_not be_valid }
  end

  describe "with a password that's too short" do
      before { @child.password = @child.password_confirmation = "a" * 5 }
      it { should be_invalid }
  end

  describe "return value of authenticate method" do
      before { @child.save }
      let(:found_child) { Child.find_by_username(@child.username) }

      describe "with valid password" do
        it { should == found_child.authenticate(@child.password) }
      end

      describe "with invalid password" do
        let(:child_for_invalid_password) { found_child.authenticate("invalid") }

        it { should_not == child_for_invalid_password }
        specify { child_for_invalid_password.should be_false }
      end
  end

  describe "remember token" do
    before { @child.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "accessible attributes" do
    it "should not allow access to parent_id" do
      expect do
        Child.new(parent_id: parent.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when parent_id is not present" do
    before { @child.parent_id = nil }
    it { should_not be_valid }
  end

  describe "when points is not present" do
    before { @child.points = nil }
    it { should_not be_valid }
  end
end
