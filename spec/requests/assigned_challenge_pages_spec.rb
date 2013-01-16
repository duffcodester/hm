require 'spec_helper'

describe "Assigned Challenge Creation" do
  
  subject { page }

  describe "assigned_challenge creation page" do
    let(:parent) { FactoryGirl.create(:parent) }
  
    before do
      sign_in parent
      visit new_assigned_challenge_path
    end

    it { should have_title('Assign a Challenge') }
    it { should have_h1('Assign a Challenge') }
    it { should have_h3('Select a challenge') }
    it { should have_h3('Select children')}
    it { should have_h3('Assign points(9-999)') }
  end
end