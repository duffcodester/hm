require 'spec_helper'

describe ResourcesController do
  let(:parent) { FactoryGirl.create(:parent) }

  before do 
    sign_in parent 
  end

  describe "creating a new challenge" do

    it "it should add the form" do
      xhr :get, :new, type: "Challenge"
      response.should be_success
    end
  end
end