# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require 'spec_helper'

describe Category do
  before { @category = Category.new(name: "Other") }

  subject { @category }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "when name is not present" do
    before { @category.name = " " }
    it { should_not be_valid }
  end

  describe "when name is not one of the allowed categories" do
    before { @category.name = "Not A Category" }
    it { should_not be_valid }
  end
end
