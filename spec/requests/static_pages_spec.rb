require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'HealthMonster' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Signin page" do
    before { visit signin_path }
    let(:heading) { 'Sign in' }
    let(:page_title) { 'Sign in' }

    it_should_behave_like "all static pages"
  end
    
  it "should have the right links on the layout" do
    visit root_path
    click_link "Register as a Parent"
    page.should have_content('Sign up')
    click_link "Home"
    page.should_not have_selector 'title', text: full_title('Sign up')
    click_link "Register as a Parent"
    click_link "HealthMonsterLogo"
    page.should_not have_selector 'title', text: full_title('Sign up')
  end

  describe "parent layout links" do
    let(:parent) { FactoryGirl.create(:parent) }
    before { sign_in(parent) }

    it "should have the correct links" do

      should have_link('Parents')
      
      should have_link('Account')
      should have_link('Profile',  href: parent_path(parent))
      should have_link('Settings', href: edit_parent_path(parent))
      should have_link('Sign out', href: signout_path)

      # challenges menu
      should have_link('Challenges')
      should have_link('Assign',   href: new_assigned_challenge_path)
      should have_link('Create',   href: new_challenge_path)
      should have_link('Your',     href: challenges_your_path)
      should have_link('Browse',   href: challenges_community_pool_path)

      # rewards menu
      should have_link('Rewards')
      should have_link('Create',   href: new_reward_path)
      should have_link('Enable',   href: new_enabled_reward_path)
      should have_link('Your',     href: rewards_your_path)
      should have_link('Browse',   href: rewards_community_pool_path)

      # children menu
      should have_link('Children')
      should have_link('Create',   href: new_child_path)
      should have_link('Your',     href: children_your_path)
    end
  end

  describe "child layout links" do
    let(:child) { FactoryGirl.create(:child) }
    before { sign_in(child) }

    it "should have the correct links" do

      should have_link('Children')
      
      should have_link('Account')
      should have_link('Profile',  href: child_path(child))
      should have_link('Settings', href: edit_child_path(child))
      should have_link('Sign out', href: signout_path)

      # challenges menu
      should have_link('Challenges')
      should have_link('Browse',   href: challenges_community_pool_path)

      # rewards menu
      should have_link('Rewards')
      should have_link('Browse',   href: rewards_community_pool_path)
    end
  end
end
