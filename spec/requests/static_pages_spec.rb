require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    
    it "should have the content 'HealthMonster'" do
      visit '/static_pages/home'
      page.should have_content('HealthMonster')
    end

    it "should have a link to Register" do
      visit '/static_pages/home'
      page.should have_link('Register as a Parent')
    end
  end
end
