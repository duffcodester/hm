require 'spec_helper'

describe SessionsHelper do
  include SessionsHelper

  describe ".current_user for parent" do
    let(:parent) { FactoryGirl.create(:parent) }
    before { sign_in parent }
    it { current_user.should eq(parent)}
  end

  describe ".current_user for child" do
    let(:child) { FactoryGirl.create(:child) }
    before { sign_in child }
    it { current_user.should eq(child)}
  end
end