require 'spec_helper'

describe "Challenge pages" do

  subject { page }

  let(:submit)   { "Create Challenge" }
  let(:parent)   { FactoryGirl.create(:parent) }
  let!(:category) { FactoryGirl.create(:category) }

  describe "challenge creation page" do 
    before { visit new_challenge_path }

    it { should have_h1('Create a Challenge') }
    it { should have_title('Create a Challenge') }
    it { should have_label("Name") }
    it { should have_label("Description") }
    it { should have_label("Category") }
    it { should have_label("Public?") }
  end

  describe "creation" do
    before do
      sign_in parent
      visit new_challenge_path
    end

    describe "with invalid information" do
      it "should not create a challenge" do
        expect { click_button submit }.not_to change(Challenge, :count)
      end
    end

    describe "with valid information" do
      before(:each) do
        fill_in "Name",         with: "Example Challenge"
        fill_in "Description",  with: "Example Challenge Description"
        select category.name, from: 'challenge[category_id]'
        check "Public?"
      end

      let(:challenge) { Challenge.find_by_name('example challenge') }

      it "should create a challenge" do
        expect { click_button submit }.to change(Challenge, :count).by(1)
      end

      describe "after saving the challenge it redirects to profile" do
        before { click_button submit }
        it { should have_success_message('You')}
        it { should have_h1(challenge.parent.name) }
      end

      describe "then the challenge page has the challenge" do
        before do
          click_button submit
          visit challenge_path(challenge)
        end

        it { should have_title(challenge.name) }
        it { should have_h1(challenge.name) }
      end
    end
  end

  let(:parent) { FactoryGirl.create(:parent) }
  let(:public_challenge) { FactoryGirl.create(:challenge, parent_id: parent.id, public: true) }
  let(:private_challenge) { FactoryGirl.create(:challenge, parent_id: parent.id, public: false) }

  before do 
    public_challenge.save
    private_challenge.save
  end

  describe "Community Pool" do
    before { visit challenges_community_pool_path }

    it { should have_h1('Challenges Community Pool') }
    it { should have_title('Challenges Community Pool') }
    it { should have_content(public_challenge.name) }
    it { should_not have_content(private_challenge.name) }

    describe "search" do

      describe "for public challenge" do
        before do
        fill_in "search", with: public_challenge.name
        click_button 'Search'
        end
  
        it { should have_content(public_challenge.name) }
      end

      describe "for private challenge" do
        before do
          fill_in "search", with: private_challenge.name
          click_button 'Search'
        end

        it { should_not have_content(private_challenge.name) }
      end
    end
  end

  describe "Your" do
    before { sign_in parent }
    before { visit challenges_your_path }

    it { should have_title('Your') }
    it { should have_h1('Your challenges') }
    it { should have_content(private_challenge.name) }
    it { should have_content(public_challenge.name) }
  end

  describe "Creating Challenges with Categories" do
    before(:each) do
      sign_in parent
      visit new_challenge_path

      fill_in "Name",         with: "Example Challenge"
      fill_in "Description",  with: "Example Challenge Description"
      check "Public?"
      click_button submit
    end

    let(:challenge) { Challenge.find_by_name('example challenge') }
    subject { challenge }

    context "without choosing a category" do
      it "should test below"
      #it { should be_created_with_category("The Arts") }
      
      # it should redirect to creation page
      # it should show error message
      # the challenge should not be in the DB
    end

    context "when one category was chosen" do
      it "should test below"
      #it { should_not be_created_with_category }

      #specify { expect to increase it{}.by(1) }
      # it should redirect to ?
      # it should show success message
      # the challenge should be in the DB
      # it should have the category
    end

    context "when multiple categories are chosen" do
      # it should redirect to ?
      # it should show success message
      # the challenge should be in the DB
      # it should have the category
    end
  end
end
