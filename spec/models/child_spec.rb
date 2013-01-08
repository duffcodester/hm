# == Schema Information
#
# Table name: children
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Child do
  let(:parent) { FactoryGirl.create(:parent) }
  before{ @child = parent.children.build(name: "Example Child",
                             email: "child@example.com",
                             password:              "foobar",
                             password_confirmation: "foobar") }

  subject { @child }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should respond_to(:parent_id) }
  it { should respond_to(:parent) }
  its(:parent) { should == parent } 

  it { should be_valid }

  describe "when name is not present" do
    before { @child.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @child.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @child.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[child@foo,com Child_at_foo.org example.Child@foo.
        foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @child.email = invalid_address
        @child.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[Child@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @child.email = valid_address
        @child.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      Child_with_same_email = @child.dup
      Child_with_same_email.email = @child.email.upcase
      Child_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @child.email = mixed_case_email
      @child.save
      @child.reload.email.should == mixed_case_email.downcase
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
      let(:found_child) { Child.find_by_email(@child.email) }

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

  describe "when email address is taken by a parent" do
    let(:parent) { FactoryGirl.create(:parent) }
    before { @child.email = parent.email }

    it { should_not be_valid}
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
end
