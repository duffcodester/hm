# == Schema Information
#
# Table name: parents
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Parent do
  before { @parent = Parent.new(name: "Example Parent",
                                email: "parent@example.com",
                                password:              "foobar",
                                password_confirmation: "foobar") }

  subject { @parent }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
    before { @parent.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
      before { @parent.email = " " }
      it { should_not be_valid }
    end

    describe "when name is too long" do
      before { @parent.name = "a" * 51 }
      it { should_not be_valid }
    end

    describe "when email format is invalid" do
      it "should be invalid" do
          addresses = %w[Parent@foo,com Parent_at_foo.org example.Parent@foo.
                     foo@bar_baz.com foo@bar+baz.com]
          addresses.each do |invalid_address|
            @parent.email = invalid_address
            @parent.should_not be_valid
          end      
      end
    end

    describe "when email format is valid" do
      it "should be valid" do
          addresses = %w[Parent@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
          addresses.each do |valid_address|
            @parent.email = valid_address
            @parent.should be_valid
          end      
      end
    end

    describe "when email address is already taken" do
      before do
          Parent_with_same_email = @parent.dup
          Parent_with_same_email.email = @parent.email.upcase
          Parent_with_same_email.save
      end

      it { should_not be_valid }
    end

    describe "email address with mixed case" do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

      it "should be saved as all lower-case" do
        @parent.email = mixed_case_email
        @parent.save
        @parent.reload.email.should == mixed_case_email.downcase
      end
    end

    describe "when password is not present" do
      before { @parent.password = @parent.password_confirmation = " " }
      it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @parent.password_confirmation = "mismatch" }
      it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
      before { @parent.password_confirmation = nil }
      it { should_not be_valid }
  end

  describe "with a password that's too short" do
      before { @parent.password = @parent.password_confirmation = "a" * 5 }
      it { should be_invalid }
  end

  describe "return value of authenticate method" do
      before { @parent.save }
      let(:found_parent) { Parent.find_by_email(@parent.email) }

      describe "with valid password" do
        it { should == found_parent.authenticate(@parent.password) }
      end

      describe "with invalid password" do
        let(:parent_for_invalid_password) { found_parent.authenticate("invalid") }

        it { should_not == parent_for_invalid_password }
        specify { parent_for_invalid_password.should be_false }
      end
  end

  describe "remember token" do
    before { @parent.save }
    its(:remember_token) { should_not be_blank }
  end

end
