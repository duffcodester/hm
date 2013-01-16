require 'spec_helper'

describe "Assigned Challenge Creation" do
  
  subject { page }

  describe "assigned_challenge creation page" do
    let(:parent) { FactoryGirl.create(:parent) }
    let(:challenge) { FactoryGirl.create(:challenge, parent_id: parent.id) }
    let(:child) { FactoryGirl.create(:child, parent_id: parent.id) }
  
    before do
      sign_in parent
      challenge.save
      child.save
      visit new_assigned_challenge_path
    end

    describe "should have the right title and page heading" do
      it { should have_title('Assign a Challenge') }
      it { should have_selector('h1', text: 'Assign a Challenge') }
    end

    describe "should have the right field labels" do
      it { should have_selector('h4', text: 'Select a challenge') }
      it { should have_selector('h4', text: 'Select children')}
      it { should have_selector('h4', text: 'Assign Points (9-999)') }
    end

    describe "should have the right choices" do
      it { should have_selector('label', text: challenge.name)  }
      it { should have_selector('label', text: child.username)  }
    end
  end
end