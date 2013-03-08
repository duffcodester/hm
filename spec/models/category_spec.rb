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

  describe "when name is already in DB" do
    before do
      Category_with_same_name = @category.dup
      Category_with_same_name.name = @category.name.upcase
      Category_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "saved as capitalized" do
    let(:multi_word_category) { "The Arts" }
    context "when all downcase" do
      before do
        @category.name = multi_word_category.downcase
        @category.save
      end

      its(:name) { should == multi_word_category }
      it { should be_valid }
    end

    context "when all upcase" do
      before do
        @category.name = multi_word_category.upcase
        @category.save
      end

      its(:name) { should == multi_word_category }
      it { should be_valid }
    end
  end
end
